
using Printf # format string in C style
using Images # core package for image

img_shaded = load("Data/Fig0229(a)(tungsten_filament_shaded).tif") .|> float32 # use Float32 to avoid unwanted overflow in N0f8
img_mask = load("Data/Fig0229(b)(tungsten_sensor_shading).tif") .|> float32
@show summary(img_shaded) summary(img_mask)
    
img_corrected = img_shaded ./ img_mask .|> Gray
    
[img_shaded img_mask img_corrected]

img_ori = load("Data/Fig0230(a)(dental_xray).tif") .|> float32
img_mask = load("Data/Fig0230(b)(dental_xray_mask).tif") .|> float32
@show summary(img_ori) summary(img_mask)

img_roi = img_ori .* img_mask .|> Gray

[img_ori img_mask img_roi]
