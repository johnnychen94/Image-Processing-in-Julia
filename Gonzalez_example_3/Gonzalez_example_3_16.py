
# coding: utf-8

# In[2]:


# Gozalez examples 3.16
# sharpen image

# importing matplotlib modules
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
from skimage import data,img_as_float
from skimage import img_as_ubyte
import math

# Read Images
img = mpimg.imread('Fig0340(a)(dipxe_text).tif')
# Output Images
plt.imshow(img,'gray')


# In[3]:


def guass(img,sigma,m):
    length = img.shape[0]
    weith = img.shape[1]
    img_final = img
    expension_num = int((m-1)/2)
    for i in range(expension_num,length-expension_num):
        for j in range(expension_num,weith-expension_num):
            temp = 0
            sum_w = 0
            for x in range(i-expension_num,i+expension_num):
                for y in range(j-expension_num,j+expension_num):
                    w = math.exp(-0.5*((x-i)**2+(y-j)**2)/(sigma**2)) 
                    sum_w += w
                    temp = temp + img[x,y] * w
            img_final[i,j] = temp/sum_w
    return img_final;


# In[4]:


#img = np.matrix(img_as_float(img))
length = img.shape[0]
weith = img.shape[1]
m = 5
expension_num = int((m-1)/2)
img1 = np.zeros((length+m-1,weith+m-1))
img1[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
plt.imshow(img1,'gray')


# In[5]:


# blue the image
sigma = 3
img_blur = guass(img1,sigma,m)
plt.imshow(img_blur,'gray')


# In[6]:


# nonsharpen mould
img1 = np.zeros((length+m-1,weith+m-1))
img1[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
plt.imshow(img1,'gray')


# In[9]:


img_mask = img1 - img_blur
plt.imshow(img_mask,'gray')


# In[10]:


# k=1
img_k1 = img1 + img_mask
plt.imshow(img_k1,'gray')


# In[11]:


# k=4.5
img_k2 = img1 + 4.5*img_mask
plt.imshow(img_k1,'gray')

