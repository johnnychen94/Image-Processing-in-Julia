
# coding: utf-8

# In[44]:


# Gozalez examples 3.2
# gamma transformation 2

# importing matplotlib modules
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
from skimage import data,img_as_float

# Read Images 
img = mpimg.imread('Fig0309(a)(washed_out_aerial_image).tif') 
# Output Images 
plt.imshow(img,'gray')


# In[35]:


img_b = img_as_float(img)**3
img_c = img_as_float(img)**4
img_d = img_as_float(img)**5


# In[40]:


plt.imshow(img_b,'gray')


# In[41]:


plt.imshow(img_c,'gray')


# In[43]:


plt.imshow(img_d,'gray')

