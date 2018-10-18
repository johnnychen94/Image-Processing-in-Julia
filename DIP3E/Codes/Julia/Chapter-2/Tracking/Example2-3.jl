
using Printf # format string in C style
using Images # core package for image

# load the original image
ori_img = load("Data/Fig0221(a).tif")

@printf "%s\n" summary(ori_img)
@printf "MIN:%s\tMAX:%s\n" extrema(ori_img)...
ori_img

# See what image intensities are
ori_img_UInt = rawview(channelview(ori_img))

@printf "%s\n" summary(ori_img_UInt)
@printf "MIN:%s\tMAX:%s\n" extrema(ori_img_UInt)... 
@printf "这是图片UInt8的十六进制表示"
ori_img_UInt

# take 2 intensity level as example
ori_img = load("Data/Fig0221(a).tif")

bit_level = 1
img = ori_img

gray_level = range(0, stop = 1, length= Int(2^bit_level+1))
@show gray_level

# let [0,0.5] be 0
inds = gray_level[1] .< img .<= gray_level[2]
img[inds] = fill(gray_level[1],length(findall(inds)))

# let [0.5,1] be 0.5
inds = gray_level[2] .< img .<= gray_level[3]
img[inds] = fill(gray_level[2],length(findall(inds)))

# normalize image again
img = img./maximum(img) # Array{N0f8}

img = colorview(Gray,img) # convert to Array{Gray{N0f8}}

# rewrite as function
function down_intensity!(img::Array{Gray{T}}, dest_bit) where T
    gray_level = range(0, stop = 1, length= Int(2^dest_bit+1))
    inds = [gray_level[i] .< img .<= gray_level[i+1] 
        for i in 1:length(gray_level)-1]
    
    # This for-loop is slow
    for i in 1:length(gray_level)-1
        img[inds[i]] = fill(gray_level[i],length(findall(inds[i])))
    end
    img = Gray{T}.(img/maximum(img))
    return img
end
function down_intensity(img::Array{Gray{T}}, dest_bit) where T
    dest_img = copy(img)
    down_intensity!(dest_img, dest_bit)
end

bit_levels = [8:-1:1...]
ori_img = load("Data/Fig0221(a).tif")

imgs = [@time down_intensity(ori_img,bit_level) for bit_level in bit_levels]

@printf "Intensity levels are:\n%d\t%d\t%d\t%d\n%d\t%d\t%d\t%d\n" (2 .^bit_levels)...
[[imgs[1] imgs[2] imgs[3] imgs[4]]
[imgs[5] imgs[6] imgs[7] imgs[8]]]

bit_levels = [8:-1:1...]
ori_img = load("Data/Fig0221(a).tif")

imgs = [@time Gray{Normed{UInt8,bit_level}}.(ori_img) # 存储类型转换即可
    for bit_level in bit_levels]

@printf "Intensity levels are:\n%d\t%d\t%d\t%d\n%d\t%d\t%d\t%d\n" (2 .^bit_levels)...
[[imgs[1] imgs[2] imgs[3] imgs[4]]
[imgs[5] imgs[6] imgs[7] imgs[8]]]

# wraparound behavior for overflow
a = N0f8(0.9)
@show -a
@show a - N0f8(0.91)

bit_levels = [8:-1:1...]
ori_img = float32.(load("Data/Fig0221(a).tif")) # convert to Float16

@time imgs_builtin = [Gray{Normed{UInt8,bit_level}}.(ori_img)
    for bit_level in bit_levels]
@time imgs_custom = [down_intensity(ori_img,bit_level) for bit_level in bit_levels]

img_diffs = imgs_builtin .- imgs_custom
@show summary(img_diffs)

@printf "Intensity levels are:\n%d\t%d\t%d\t%d\n%d\t%d\t%d\t%d\n" (2 .^bit_levels)...
[[img_diffs[1] img_diffs[2] img_diffs[3] img_diffs[4]]
[img_diffs[5] img_diffs[6] img_diffs[7] img_diffs[8]]]

# Let's check the behavior
graybar = Gray{N0f8}.(transpose(repeat(range(0,stop=1,length=512),1,50)))

bits = 4:-1:1
imgs_builtin = [Gray{N0f8}.(Gray{Normed{UInt8, bit}}.(graybar)) for bit in bits] 
imgs_custom = [down_intensity(graybar, bit) for bit in bits]

img_diffs = colorview(Gray,hcat(vcat(imgs_builtin...),vcat(imgs_custom...)))
