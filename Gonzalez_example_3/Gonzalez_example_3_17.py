
# coding: utf-8

# In[21]:


# Gozalez examples 3.17
# sharpen edge

# importing matplotlib modules
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
from skimage import data,img_as_float
from skimage import img_as_ubyte
import math

# Read Images
img = mpimg.imread('Fig0342(a)(contact_lens_original).tif')
# Output Images
plt.imshow(img,'gray')


# In[23]:


img = np.matrix(img_as_float(img))
length = img.shape[0]
weith = img.shape[1]
img1 = np.zeros((length+2,weith+2))
img1[1:(length+1),1:(weith+1)] = img
for i in range(1,length-1):
    for j in range(1,weith-1):
        img1[i,j] = abs(-img[i-1,j-1] - 2*img[i-1,j] -img[i-1,j+1] +        img[i+1,j-1] + 2*img[i+1,j] + img[i+1,j+1])+        abs(-img[i-1,j-1] - 2*img[i,j-1] +-img[i+1,j-1] +        +img[i-1,j+1] + 2*img[i,j+1] + img[i+1,j+1])
plt.imshow(img1,'gray')

