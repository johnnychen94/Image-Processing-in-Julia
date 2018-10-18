
using Printf # format string in C style
using Images # core package for image

mask_img = load("Data/Fig0228(a).tif") .|> float32 # use Float32 to avoid unwanted overflow in N0f8
live_img = load("Data/Fig0228(b).tif") .|> float32
@show summary(mask_img) summary(live_img)
hcat(mask_img,live_img)

diff_img = imadjustintensity(live_img - mask_img)
enhanced_diff_img = colorview(Gray, exp10.(channelview(diff_img))) |> imadjustintensity

[mask_img live_img; diff_img enhanced_diff_img]
