# ---
# cover: example_2_2.png
# id: dip_example_2_2
# ---

# 本例展示了图片在不同空间分辨率下的显示效果

using Images, DIPTutorials

# 读取示例图片
ori_img = load(DIP3e.get_filepath("Fig0220")) # 3692×2812 Gray image

# 由于dpi是一个跟打印有关的概念，这里以原始图片为标准大小进行模拟：
#
# 1. 对原始图片进行下采样
# 2. 将下采样的图片再上采样回原尺寸
# 
# 简单起见，下采样与上采样使用了`imresize`函数，关于`imresize`的实现在[例2-4](@ref dip_example_2_4)中会介绍

## 设置DPI
img_dpis = [1250, 300, 150, 72]
img_sizes = [ceil.(Int, dpi/1250 .* size(ori_img)) for dpi in img_dpis]
## 下采样
downsampled_imgs = [imresize(ori_img, sz) for sz in img_sizes]
## 上采样
upsampled_imgs = [imresize(img, size(ori_img)) for img in downsampled_imgs]
nothing #hide #!jl

# 展示结果：第一行为下采样之后的结果，第二行为对应放大之后显示的结果。
# 从结果可以看到，在相同尺寸下显示/打印出来时，图片分辨率越低意味着dpi越低，锯齿状也越明显
vcat(mosaicview(downsampled_imgs, nrow=1),
     mosaicview(upsampled_imgs, nrow=1))

# save cover #src
save("example_2_2.png", imresize(ori_img, (220, 200))) #src
