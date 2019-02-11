#!/usr/bin/env python
# coding: utf-8

# **Examples 3.3:** Intensity-level slicing
# 
# This example includes figure 3.12.
# 
# > This code is written with python==3.7, skimage==0.14, matplotlib==2.2.3, numpy==1.15

# In[1]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
from skimage.io import imread
import numpy as np


# In[2]:


# read and show original image
src_img = imread('./Data/Fig0312(a)(kidney).tif')

plt.figure(figsize=(5,5))
plt.imshow(src_img,'gray')
plt.title('Aortic angiogram near the kidney area')
plt.show()


# In[3]:


def demo_b(src_img, A,B, L=0,H=255):
    """set intensity of interest [A,B] to H, other pixels are set to L."""
    assert(src_img.dtype == np.dtype('uint8'))
    dest_img = np.zeros_like(src_img) + L
    dest_img[np.logical_and(A<=src_img, src_img<=B)] = H
    return dest_img


# In[4]:


def demo_c(src_img, A,B, I=0):
    """set intensity of interest [A,B] to I, other pixels are unchanged."""
    assert(src_img.dtype == np.dtype('uint8'))
    dest_img = src_img.copy()
    dest_img[np.logical_and(A<=src_img, src_img<=B)] = I
    return dest_img


# In[5]:


# intensity-level slicing
dest_imgs = [src_img,
             demo_b(src_img,150,255),
             demo_c(src_img,0,150)]


# In[6]:


# plot Figure 3.12
# Note: this result is not exactly the same as that on the textbook.
fig = plt.figure(figsize=(15,5))
plt.title("Figure 3.12")
plt.axis('off')
axeslist = fig.subplots(1,3)
for (i, axes) in enumerate(axeslist.ravel()):
    axes.imshow(dest_imgs[i],'gray',vmin=0,vmax=255)
    axes.set_axis_off()
plt.show()

