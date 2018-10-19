
# coding: utf-8

# In[32]:


# Gozalez examples 3.6
# Histogram Equalization

# importing matplotlib modules
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
from skimage import data,img_as_float
from skimage import img_as_ubyte


# In[33]:


def hist_eq(img):
    hist = np.zeros(256)
    
    for i in range(0,length):
        for j in range(0,weith):
            temp = img.item(i,j)
            hist[temp] += 1

    pr = np.zeros(256)
    pr = hist/(length*weith)

    s = np.zeros(256)
    temp = 0
    for i in range(0,256):
        temp = temp + pr[i]
        s[i] = round(255*temp)
   
    img1 = np.zeros((length,weith))
        
    for i in range(0,length):
        for j in range(0,weith):
            temp = img[i,j]
            img1[i,j] = s[temp]
    return img1


# In[34]:


img = mpimg.imread('Fig0320(1)(top_left).tif')
img1 = hist_eq(img)
plt.figure()
plt.subplot(1,2,1)
plt.imshow(img,'gray')
plt.subplot(1,2,2)
plt.imshow(img1,'gray')
plt.figure()
plt.subplot(2,1,1)
n, bins, patches = plt.hist(img.reshape(length*weith), bins=256,edgecolor='None',facecolor='red')
plt.subplot(2,1,2)
n, bins, patches = plt.hist(img1.reshape(length*weith), bins=256,edgecolor='None',facecolor='red')


# In[35]:


# Read Images
img2 = mpimg.imread('Fig0320(2)(2nd_from_top).tif')
# Output Images
img3 = hist_eq(img2)
plt.figure()
plt.subplot(1,2,1)
plt.imshow(img2,'gray')
plt.subplot(1,2,2)
plt.imshow(img3,'gray')
plt.figure()
plt.subplot(2,1,1)
n, bins, patches = plt.hist(img2.reshape(length*weith), bins=256,edgecolor='None',facecolor='red')
plt.subplot(2,1,2)
n, bins, patches = plt.hist(img3.reshape(length*weith), bins=256,edgecolor='None',facecolor='red')


# In[37]:


# Read Images
img4 = mpimg.imread('Fig0320(3)(third_from_top).tif')
# Output Images
img5 = hist_eq(img4)
plt.figure()
plt.subplot(1,2,1)
plt.imshow(img4,'gray')
plt.subplot(1,2,2)
plt.imshow(img5,'gray')
plt.figure()
plt.subplot(2,1,1)
n, bins, patches = plt.hist(img4.reshape(length*weith), bins=256,edgecolor='None',facecolor='red')
plt.subplot(2,1,2)
n, bins, patches = plt.hist(img5.reshape(length*weith), bins=256,edgecolor='None',facecolor='red')


# In[39]:


# Read Images
img6 = mpimg.imread('Fig0320(4)(bottom_left).tif')
# Output Images
img7 = hist_eq(img6)
plt.figure()
plt.subplot(1,2,1)
plt.imshow(img6,'gray')
plt.subplot(1,2,2)
plt.imshow(img7,'gray')
plt.figure()
plt.subplot(2,1,1)
n, bins, patches = plt.hist(img6.reshape(length*weith), bins=256,edgecolor='None',facecolor='red')
plt.subplot(2,1,2)
n, bins, patches = plt.hist(img7.reshape(length*weith), bins=256,edgecolor='None',facecolor='red')

