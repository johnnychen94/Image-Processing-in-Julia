
using Printf # format string in C style
using Images # core package for image

ori_img = load("Data/Fig0226(galaxy_pair_original).tif") .|> float32 # use Float32 to avoid unwanted overflow in N0f8
@show summary(ori_img)
ori_img

function imnoise_gaussian(img::AbstractArray{T}, variance::Number, mean::Number)::AbstractArray{T} where T
    return clamp01.(img + sqrt(variance)*randn(size(img)) .+ mean)
end
imaverage(img,num) = sum([imnoise_gaussian(img,0.01,0) for i in 1:num])/num

imgs = [imaverage(ori_img,num) for num in [1,5,10,20,50,100]]
vcat(hcat(imgs[1:3]...),hcat(imgs[4:6]...))
