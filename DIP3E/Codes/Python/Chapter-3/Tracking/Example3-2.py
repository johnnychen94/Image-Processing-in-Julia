
# coding: utf-8

# Gozalez examples 3.2
# gamma transformation 2

# In[1]:


import matplotlib.image as mpimg
import matplotlib.pyplot as plt
from skimage import data,img_as_float

# Read Images 
img = mpimg.imread('Fig0309(a)(washed_out_aerial_image).tif') 
# Output Images 
plt.imshow(img,'gray')


# In[2]:


img_b = img_as_float(img)**3
img_c = img_as_float(img)**4
img_d = img_as_float(img)**5


# In[3]:


plt.figure()
plt.imshow(img_b,'gray')
plt.figure()
plt.imshow(img_c,'gray')
plt.figure()
plt.imshow(img_d,'gray')

