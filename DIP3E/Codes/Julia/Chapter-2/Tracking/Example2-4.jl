
using Printf # format string in C style
using Images # core package for image

"""
    nearest_raw(img, sz)

use nearest neighbor interpolation to resize an image.

Nearest neighbor interpolation assign the value of the 'nearest' pixel to new pixels.
It is simple but might produce undesirable artifacts, such as severe distortion of straight edges.
"""
function nearest_raw(img, sz)
    ori_sz = size(img)
    length(ori_sz) == length(sz) || ArgumentError("Wrong sz")
    
    # you might wanna combine this three arrays into one to reduce memory usage
    pixels = [[x,y] for x in 1:sz[1], y in 1:sz[2]] # new image pixels
    pixels_ori = [ pixel .* ori_sz ./ sz for pixel in pixels] # new image pixels in original board
    # nearest pixels
    pixels_nearest = [ [clamp(round(Int, pixel[1]), 1, ori_sz[1]),
            clamp(round(Int, pixel[2]), 1, ori_sz[2])]
        for pixel in pixels_ori] # use clamp to make sure imdex is valid 
    
    dest_img = similar(img, sz...) # create a arrary with the same type of img, with size=sz
    for pixel in pixels
        nearest_pixel = pixels_nearest[pixel...]
        dest_img[pixel...] = img[nearest_pixel...]
    end
    return dest_img
end

mutable struct Point{T}
    value::T
    pos::AbstractArray
end
Base.copy(p::Point) = Point(copy(p.value),copy(p.pos))

# Define linear interpolation for bilinear
d(pos1,pos2) = abs2.(pos1-pos2) |> sum |> sqrt
function linear!(p::Point{T}, p1::Point{T}, p2::Point{T}) where T# This will change the value of p
    if p1.pos == p2.pos
        p.value = (p1.value+p2.value)/2
    else
        p.value = p1.value * T(d(p2.pos, p.pos)/d(p1.pos, p2.pos)) +
           p2.value * T(d(p1.pos, p.pos)/d(p1.pos, p2.pos))
    end
    return p
end
"""
    linear(p,p1,p2)

Linear interpolation of p with information of p1 and p2
"""
function linear(p::Point, p1::Point, p2::Point) # This will not change the value of p
    p_dest = copy(p)
    linear!(p_dest, p1, p2)
    return p_dest
end

"""
    bilinear_raw(img,sz)

use bilinear interpolation to resize an image.
"""
function bilinear_raw(img, sz)
    ori_sz = size(img)
    length(ori_sz) == length(sz) || ArgumentError("Wrong sz")
    
    # the same procedure as nearest neighbor
    pixels = [[x,y] for x in 1:sz[1], y in 1:sz[2]] # new image pixels
    pixels_ori = [ pixel .* ori_sz ./ sz for pixel in pixels] # new image pixels in original board
    
    dest_img = similar(img, sz...) # create a arrary with the same type of img, with size=sz
    for pixel in pixels
        # get four near pixels
        pixel_ori = pixels_ori[pixel...]
        t = clamp(floor(Int, pixel_ori[1]), 1, ori_sz[1]) # x top
        b = clamp(ceil(Int, pixel_ori[1]), 1, ori_sz[1]) # x bottom
        l = clamp(floor(Int, pixel_ori[2]), 1, ori_sz[2]) # y left
        r = clamp(ceil(Int, pixel_ori[2]), 1, ori_sz[2]) # y right
        
        TL = [t,l]
        TR = [t,r]
        BL = [b,l]
        BR = [b,r]
        
        # do linear interpolation for three times
        T = [t, pixel_ori[2]] # top
        B = [b, pixel_ori[2]] # bottom
        Point_T = linear(
            Point(img[TL...],T),
            Point(img[TL...],TL),
            Point(img[TR...],TR))
        Point_B = linear(
            Point(img[BL...],B),
            Point(img[BL...],BL),
            Point(img[BR...],BR))
        Point_p = linear(
            Point(dest_img[pixel...],pixel_ori),
            Point_T, Point_B)
        
        dest_img[pixel...] = Point_p.value
    end
    return dest_img
end

function bicubic_raw
end

ori_img = load("Data/Fig0220(a).tif") .|> float32 # use Float32 to avoid unwanted overflow in N0f8
@show summary(ori_img)

ori_dpi = 1250
dpis = [72, 150]
# make sure to add round.(Int, sz), otherwise it will throw StackOverflow Error
szs = [round.(Int, size(ori_img) .* dpi ./ ori_dpi) for dpi in dpis] 

src_imgs = [imresize(ori_img, sz) for sz in szs]

nearest(img,sz) = nearest_raw(img,sz)
bilinear(imgs,sz) = bilinear_raw(imgs,sz)

imgs_nearest = [@time nearest(img,size(ori_img)) for img in src_imgs] # takes 30 seconds
imgs_bilinear = [@time bilinear(img,size(ori_img)) for img in src_imgs] # takes almost 2-min

hcat(vcat(imgs_nearest...),
    vcat(imgs_bilinear...))

function nearest_fast(img::Array{T}, sz) where T
    ori_sz = size(img)
    length(ori_sz) == length(sz) || ArgumentError("Wrong sz")
    
    dest_img = similar(img,sz...) # create a arrary with the same type of img, with size=sz
    ratio = ori_sz./sz
    for i in 1:sz[1], j in 1:sz[2]
        dest_img[i,j] = img[clamp(round(Int, i * ratio[1]), 1, ori_sz[1]),
            clamp(round(Int, j * ratio[2]), 1, ori_sz[2])]
    end
    return dest_img
end

function bilinear_fast(img::T, sz)::T where T
    ori_sz = size(img)
    length(ori_sz) == length(sz) || ArgumentError("Wrong sz")

    ratio = ori_sz ./ sz
    dest_img = similar(img,sz...) # create a arrary with the same type of img, with size=sz
    for i in 1:sz[1], j in 1:sz[2]
        x,y = [i,j].*ratio
        t = clamp(floor(Int, x), 1, ori_sz[1]) # x top
        b = clamp(ceil(Int, x), 1, ori_sz[1]) # x bottom
        l = clamp(floor(Int, y), 1, ori_sz[2]) # y left
        r = clamp(ceil(Int, y), 1, ori_sz[2]) # y right
        
        if [b,r] == [t,l]
            dest_img[i,j] = img[t,l]
            continue
        end
        
        if b == t
            dest_img[i,j] = ((y-l)img[b,r]+(r-y)img[b,l])/(r-l)
            continue
        end
        
        if r == l
            dest_img[i,j] = ((x-t)img[b,l]+(b-x)img[t,l])/(b-t)
            continue
        end

        dest_img[i,j] = ((b-x)*(r-y)*img[t,l] +
            (x-t)*(r-y)*img[b,l] +
            (b-x)*(y-l)*img[t,r] +
            (x-t)*(y-l)*img[b,r]) / ((b-t)*(r-l))
    end
    return dest_img
end

ori_img = load("Data/Fig0220(a).tif") .|> float32
ori_dpi = 1250
dpis = [72, 150]
szs = [round.(Int, size(ori_img) .* dpi ./ ori_dpi) for dpi in dpis] 
src_imgs = [imresize(ori_img, sz) for sz in szs]

nearest(img,sz) = nearest_fast(img,sz)
bilinear(img,sz) = bilinear_fast(img,sz)

imgs_nearest = [@time nearest(img, size(ori_img)) for img in src_imgs] # takes 0.2 seconds
imgs_bilinear = [@time bilinear(img,size(ori_img)) for img in src_imgs] # takes 4.8 seconds

hcat(vcat(imgs_nearest...),
    vcat(imgs_bilinear...))

using Interpolations, ImageTransformations

function imresize_interpolate(img::AbstractArray{S,N}, method::String) where {S,N}
    if method == "nearest"
        return interpolate(img, BSpline(Constant()))
    end
    if method == "bilinear"
        return interpolate(img, BSpline(Linear()))
    end
    if method == "bicubic"
        return interpolate(img, BSpline(Cubic(Line(OnGrid()))))
    end
end

function ImageTransformations.imresize!(resized::AbstractArray{T,N}, original::AbstractArray{S,N}, method::String) where {T,S,N}
    ImageTransformations.imresize!(resized, imresize_interpolate(original,method))
end

function ImageTransformations.imresize(original::AbstractArray{T,N}, new_size::Dims{N}, method::String) where {T,N}
    ImageTransformations.imresize!(similar(original, new_size), original, method)
end

ori_img = load("Data/Fig0220(a).tif") .|> float32
ori_dpi = 1250
dpis = [72, 150]
szs = [round.(Int, size(ori_img) .* dpi ./ ori_dpi) for dpi in dpis] 
src_imgs = [imresize(ori_img, sz) for sz in szs]

nearest(img,sz) = imresize(img,sz,"nearest")
bilinear(img,sz) = imresize(img,sz,"bilinear")
bicubic(img,sz) = imresize(img,sz,"bicubic")

imgs_nearest = [@time nearest(img, size(ori_img)) for img in src_imgs]
imgs_bilinear = [@time bilinear(img, size(ori_img)) for img in src_imgs]
imgs_bicubic = [@time bicubic(img, size(ori_img)) for img in src_imgs]

hcat(vcat(imgs_bilinear...),
    vcat(imgs_bilinear...),
    vcat(imgs_bicubic...))
