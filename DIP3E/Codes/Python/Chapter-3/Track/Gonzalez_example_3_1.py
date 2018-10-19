
# coding: utf-8

# In[4]:


# Gozalez examples 3.1 
# contrast enhance using gamma transformation 

# importing matplotlib modules 
import matplotlib.image as mpimg 
import matplotlib.pyplot as plt

# Read Images 
img = mpimg.imread('Fig0308(a)(fractured_spine).tif') 
  
# Output Images 
plt.imshow(img,'gray')


# In[6]:


img_b = img**0.6
img_c = img**0.4
img_d = img**0.3


# In[8]:


plt.imshow(img_b,'gray')


# In[9]:


plt.imshow(img_c,'gray')


# In[10]:


plt.imshow(img_d,'gray')

