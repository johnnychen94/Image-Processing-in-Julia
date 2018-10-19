
# coding: utf-8

# In[5]:


# Gozalez examples 3.3
# Grayscale layering

# importing matplotlib modules
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
from skimage import data,img_as_float

# Read Images
img = mpimg.imread('Fig0312(a)(kidney).tif') 
# Output Images
plt.imshow(img,'gray')


# In[2]:


img_b = img>149
img_b = (img_b==True)*153 + (img_b==False)*25
plt.imshow(img_b,'gray')


# In[3]:


img_c = (img>149)
img_c = img_c*200 + img*(img_c==False)
plt.imshow(img_c,'gray')

