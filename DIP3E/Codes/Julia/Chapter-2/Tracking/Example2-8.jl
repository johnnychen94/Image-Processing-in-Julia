
using Printf # format string in C style
using Images # core package for image

img_ori = load("Data/Fig0232(a)(partial_body_scan).tif") .|> float32 # use Float32 to avoid unwanted overflow in N0f8

img_neg = 1 .- img_ori .|> Gray # 1-minus as complementation

img_union = max.(0.3, img_ori) .|> Gray # max as union, min as intersection

[img_ori img_neg img_union]
