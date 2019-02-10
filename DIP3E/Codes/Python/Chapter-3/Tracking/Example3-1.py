#!/usr/bin/env python
# coding: utf-8

# **Examples 3.1:** Contrast enhance using gamma transformation
# 
# This example includes figure 3.8.
# 
# > This code is written with python==3.7, skimage==0.14, matplotlib==2.2.3

# In[1]:


from skimage.io import imread
import matplotlib.pyplot as plt

# Read Images 
img = imread('./Data/Fig0308(a)(fractured_spine).tif').astype(float)
  
# Output Images 
plt.imshow(img,'gray')


# In[2]:


# contrast manipulation by power-law transformation
img_b = img**0.6
img_c = img**0.4
img_d = img**0.3


# In[3]:


# Figure 3.8
plt.figure(figsize=(15,15))
plt.subplot(2,2,1)
plt.imshow(img_b,'gray')
plt.subplot(2,2,2)
plt.imshow(img_b,'gray')
plt.subplot(2,2,3)
plt.imshow(img_c,'gray')
plt.subplot(2,2,4)
plt.imshow(img_c,'gray')

