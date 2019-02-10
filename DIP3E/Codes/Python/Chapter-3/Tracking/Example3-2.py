#!/usr/bin/env python
# coding: utf-8

# **Examples 3.2:** Another illustration of power-law transformations.
# 
# This example includes figure 3.9.
# 
# > This code is written with python==3.7, skimage==0.14, matplotlib==2.2.3

# In[1]:


import matplotlib.pyplot as plt
from skimage.io import imread

# Read Images 
img = imread('./Data/Fig0309(a)(washed_out_aerial_image).tif').astype(float)

# Output Images 
plt.imshow(img,'gray')


# In[2]:


# contrast manipulation by power-law transformation
img_b = img**3.0
img_c = img**4.0
img_d = img**5.0


# In[3]:


# Figure 3.9
plt.figure(figsize=(15,15))
plt.subplot(2,2,1)
plt.imshow(img_b,'gray')
plt.subplot(2,2,2)
plt.imshow(img_b,'gray')
plt.subplot(2,2,3)
plt.imshow(img_c,'gray')
plt.subplot(2,2,4)
plt.imshow(img_c,'gray')
plt.show()

