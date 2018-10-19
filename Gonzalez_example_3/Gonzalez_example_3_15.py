
# coding: utf-8

# In[19]:


# Gozalez examples 3.15
# sharpen image using laplace filter

# importing matplotlib modules
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
from skimage import data,img_as_float
from skimage import img_as_ubyte

# Read Images
img = mpimg.imread('Fig0338(a)(blurry_moon).tif')
# Output Images
plt.imshow(img,'gray')


# In[24]:


img = np.matrix(img_as_float(img))
length = img.shape[0]
weith = img.shape[1]
img1 = np.zeros((length,weith))
for i in range(1,length-1):
    for j in range(1,weith-1):
        img1[i,j] = (img[i-1,j] + img[i,j-1] - 4*img[i,j] + img[i,j+1] + img[i+1,j])
plt.imshow(img1,'gray')


# In[25]:


img2 = np.zeros((length,weith))
for i in range(1,length-1):
    for j in range(1,weith-1):
        img2[i,j] = (img[i-1,j-1] + img[i-1,j] + img[i-1,j+1] + img[i,j-1] - 8*img[i,j] + img[i-1,j+1] +         img[i+1,j-1] + img[i+1,j] + img[i+1,j+1])
plt.imshow(img2,'gray')


# In[26]:


img3 = np.zeros((length,weith))
for i in range(1,length-1):
    for j in range(1,weith-1):
        img3[i,j] = (- img[i-1,j] - img[i,j-1] - 4*img[i,j] - img[i,j+1] - img[i+1,j])
plt.imshow(img3,'gray')


# In[27]:


img4 = np.zeros((length,weith))
for i in range(1,length-1):
    for j in range(1,weith-1):
        img4[i,j] = (-img[i-1,j-1] - img[i-1,j] - img[i-1,j+1] - img[i,j-1] - 8*img[i,j] - img[i-1,j+1] -         img[i+1,j-1] - img[i+1,j] - img[i+1,j+1])
plt.imshow(img4,'gray')

