# Digital-Image-Processing-Gonzalez
Codes for most examples in the famous textbook Digital Image Processing (Gonzalez) [3rd Edition [Amazon]](https://www.amazon.com/Digital-Image-Processing-Rafael-Gonzalez/dp/013168728X/ref=sr_1_2?ie=UTF8&qid=1535526723&sr=8-2&keywords=digital+image+processing). I hope this can help you understand the mentioned concepts better.

## Usage
* For Julia: running the `ipynb` file in jupyter notebook and see what happens. The `ipynb` files contain results for convenience and `jl` files are used to track differences. Check [IJulia](https://github.com/JuliaLang/IJulia.jl) for installation and usage.
* For Python: same as Julia. `py` files are used to track differences.
* For MATLAB: since MATLAB live script runs very slow at present, `m` file is provided without results.

Explanations and additional codes are added to these examples for better understanding.

## TOC for 3rd Edition
* **Chapter 2 : Digital Image Fundamentals**
  - [x] EXAMPLE 2.2: Illustration of the effects of reducing image spatial resolution. Including Figure 2.20 [Julia](DIP3E/Codes/Julia/Chapter-2/Example2-2.ipynb)
  - [x] EXAMPLE 2.3: Typical effects of varing the number of intensity levels in a digital image. Inlcuding Figure 2.21 [Julia](DIP3E/Codes/Julia/Chapter-2/Example2-3.ipynb)
  - [x] EXAMPLE 2.4: Comparison of interpolation approaches for image shrinking and zooming. Including Figure 2.24 [Julia](DIP3E/Codes/Julia/Chapter-2/Example2-4.ipynb) (Uncomplete: bicubic)
  - [x] EXAMPLE 2.5: Addition (averaging) of noisy images for noise reduction. Including Figure 2.26 [Julia](DIP3E/Codes/Julia/Chapter-2/Example2-5.ipynb)
  - [x] EXAMPLE 2.6: Image subtraction for enhancing differences. Including Figure 2.27, 2.28 [Julia](DIP3E/Codes/Julia/Chapter-2/Example2-6.ipynb) (Uncomplete: Figure 2.27)
  - [x] EXAMPLE 2.7: Using image multiplication and division for shading correction. Including Figure 2.29, 2.30 [Julia](DIP3E/Codes/Julia/Chapter-2/Example2-7.ipynb)
  - [x] EXAMPLE 2.8: Set operations involving image intensities. Including Figure 2.32 [Julia](DIP3E/Codes/Julia/Chapter-2/Example2-8.ipynb)
  - [x] EXAMPLE 2.9: Image rotation and intensity interpolation. Including Figure 2.36 [Julia](DIP3E/Codes/Julia/Chapter-2/Example2-9.ipynb)
  - [ ] EXAMPLE 2.10: Image registration. Including Figure 2.37
  - [ ] EXAMPLE 2.11: Image processing in the transform domain. Including Figure 2.40
  - [ ] EXAMPLE 2.12: Comparison of standard deviation values as measures of image intensity contrast. Including Figure 2.41
* **Chapter 3 : Intensity Transformations and Spatial Filtering**
  - [x] EXAMPLE 3.1: Contrast enhancement using power-law transformations. Including Figure 3.8  [Python](DIP3E/Codes/Python/Chapter-3/Example3-1.ipynb)
  - [x] EXAMPLE 3.2: Another illustration of power-law transformations. Including Figure 3.9  [Python](DIP3E/Codes/Python/Chapter-3/Example3-2.ipynb)
  - [x] EXAMPLE 3.3: Intensity-level slicing. Including Figure 3.12  [Python](DIP3E/Codes/Python/Chapter-3/Example3-3.ipynb)
  - [ ] EXAMPLE 3.6: Histogram equalization. Including Figure 3.20
  - [ ] EXAMPLE 3.9: Comparison between histogram equalization and histogram matching. Including Figure 3.23, 3.24, and 3.25
  - [ ] EXAMPLE 3.10: Local histogram equalization. Including Figure 3.26
  - [ ] EXAMPLE 3.12: Local enhancement using histogram statistics. Including Figure 3.27
  - [ ] EXAMPLE 3.13: Image smoothing with masks of various sizes. Including Figure 3.33
  - [ ] EXAMPLE 3.14: Use of median filtering for noise reduction. Including Figure 3.35
  - [ ] EXAMPLE 3.15: Image sharpening using the Laplacian. Including Figure 3.38
  - [ ] EXAMPLE 3.16: Image sharpening using unsharp masking. Including Figure 3.40
  - [ ] EXAMPLE 3.17: Use of the gradient for edge enhancement. Including Figure 3.42
  - [ ] EXAMPLE 3.19: Illustration of image enhancement using fuzzy, rulebased contrast modification. Including Figure 3.54 and 3.55
  - [ ] EXAMPLE 3.20: Illustration of boundary enhancement using fuzzy, rulebased spatial filtering. Including Figure 3.59
* **Chapter 4 : Filtering in the Frequency Domain**
* **Chapter 5 : Image Restoration and Reconstruction**
* **Chapter 6 : Color Image Processing**
* **Chapter 7 : Wavelets and Multiresolution Processing**
* **Chapter 8 : Image Compression**
* **Chapter 9 : Morphological Image Processing**
* **Chapter 10 : Image Segmentation**
* **Chapter 11 : Representation and Description**
* **Chapter 12 : Object Recognition**

## Contribution:

### Issue
For example you don't understand and want codes *immediately*, you could create an issue

### Pull request
* Open *one* pull request(PR) for each single example, so that I can review it easier
* Each PR should contain your codes and data(if not exists), and modify corresponding part of this `README.md`
* For codes written in `ipynb` 
	* you should contain the corresponding `py` or `jl` files for easy diff tracking. Make sure `py` and `ipynb` contains the same codes.
	* make sure to `restart kernel and run all cells` to keep your results for connivence
	* make sure to delete unnecessary empty cells, e.g., the last one

## Links:
* ~You may also want to try [Dive into Julia](https://github.com/johnnychen94/Dive-Into-Julia), which is a "Learn Julia the Hard Way" tutorial.~
