
using Printf # format string in C style
using Images # core package for image

# load the original image
ori_img = load("Data/Fig0220(a).tif")
@printf "%s\n" summary(ori_img)
ori_img

# downsample the original image

img_dpis = [1250, 300, 150, 72]
img_sizes = [ceil.(Int, dpi/1250 .* size(ori_img)) for dpi in img_dpis]
# for simplicity we use `imresize` here
downsampled_imgs = [imresize(ori_img, sz) for sz in img_sizes] 
[@printf "%s\n" summary(img) for img in downsampled_imgs]
downsampled_imgs

# upsample the downsampled images
upsampled_imgs = [imresize(img, size(ori_img)) for img in downsampled_imgs]

# combine four images into a new large image for show
# Row 1: 1250 300
# Row 2: 150 72
@printf "dpis of images are: \n%d\t%d\n%d\t%d\n" 1250 300 150 72
[upsampled_imgs[1] upsampled_imgs[2]; upsampled_imgs[3] upsampled_imgs[4]]
