
# coding: utf-8

# In[1]:


# Gozalez examples 3.14
# denoise using filter

# importing matplotlib modules
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
from skimage import data,img_as_float
from skimage import img_as_ubyte

# Read Images
img = mpimg.imread('Fig0335(a)(ckt_board_saltpep_prob_pt05).tif')
# Output Images
plt.imshow(img,'gray')


# In[2]:


img = np.matrix(img_as_float(img))
length = img.shape[0]
weith = img.shape[1]
img1 = np.zeros((length,weith))
for i in range(1,length-1):
    for j in range(1,weith-1):
        img1[i,j] = (img[i-1,j-1] + img[i-1,j] + img[i-1,j+1] + img[i,j-1] + img[i,j] + img[i-1,j+1] +         img[i+1,j-1] + img[i+1,j] + img[i+1,j+1])/9


# In[3]:


plt.imshow(img1,'gray')


# In[4]:


img2 = np.zeros((length,weith))
for i in range(1,length-1):
    for j in range(1,weith-1):
        img2[i,j] = np.median([img[i-1,j-1] , img[i-1,j] , img[i-1,j+1] , img[i,j-1] , img[i,j] , img[i-1,j+1] ,         img[i+1,j-1] , img[i+1,j] , img[i+1,j+1]])


# In[5]:


plt.imshow(img2,'gray')

