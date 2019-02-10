#!/usr/bin/env python
# coding: utf-8

# **Examples 3.1:** Contrast enhance using gamma transformation
# 
# This example includes figure 3.8.
# 
# gamma transformation: $s = cr^\gamma$
# > This code is written with python==3.7, skimage==0.14, matplotlib==2.2.3

# In[1]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
from skimage.io import imread


# In[2]:


# read and show original image
src_img = imread('./Data/Fig0308(a)(fractured_spine).tif').astype(float)

plt.figure(figsize=(10,10))
plt.imshow(src_img,'gray')
plt.title('Magnetic resonance image (MRI) of a fractured human spine')
plt.show()


# In[3]:


# contrast manipulation by power-law transformation
c = 1.0
gammas = [1.0, 0.6, 0.4, 0.3] # subfigure: a, b, c, d
dest_imgs = [c*src_img**gamma for gamma in gammas]


# In[4]:


# plot Figure 3.8
fig = plt.figure(figsize=(15,15))
plt.title("Figure 3.8: Contrast enhance using gamma transformation")
plt.axis('off')
axeslist = fig.subplots(2,2)
for (i, axes) in enumerate(axeslist.ravel()):
    axes.imshow(dest_imgs[i],'gray')
    axes.set_title(f"$\gamma={gammas[i]}$")
    axes.set_axis_off()
plt.show()

