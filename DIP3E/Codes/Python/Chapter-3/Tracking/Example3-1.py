
# coding: utf-8

# Gozalez examples 3.1 
# contrast enhance using gamma transformation 

# In[1]:


import matplotlib.image as mpimg 
import matplotlib.pyplot as plt

# Read Images 
img = mpimg.imread('./Data/Fig0308(a)(fractured_spine).tif') 
  
# Output Images 
plt.imshow(img,'gray')


# In[2]:


img_b = img**0.6
img_c = img**0.4
img_d = img**0.3


# In[3]:


plt.figure()
plt.subplot(1,3,1)
plt.imshow(img_b,'gray')
plt.subplot(1,3,2)
plt.imshow(img_c,'gray')
plt.subplot(1,3,3)
plt.imshow(img_c,'gray')

