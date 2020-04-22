using Images, DIPTutorials

ori_img = load(DIP3e.get_filepath("Fig0220")) # 3692×2812 Gray image

# 设置DPI
img_dpis = [1250, 300, 150, 72]
img_sizes = [ceil.(Int, dpi/1250 .* size(ori_img)) for dpi in img_dpis]
# 下采样
downsampled_imgs = [imresize(ori_img, sz) for sz in img_sizes]
# 上采样
upsampled_imgs = [imresize(img, size(ori_img)) for img in downsampled_imgs]

vcat(mosaicview(downsampled_imgs, nrow=1),
     mosaicview(upsampled_imgs, nrow=1))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

