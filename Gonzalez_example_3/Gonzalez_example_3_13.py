
# coding: utf-8

# In[2]:


# Gozalez examples 3.13
# smooth

# importing matplotlib modules
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
from skimage import data,img_as_float
from skimage import img_as_ubyte

# Read Images
img = mpimg.imread('Fig0333(a)(test_pattern_blurring_orig).tif')
# Output Images
plt.imshow(img,'gray')


# In[3]:


img = np.matrix(img_as_float(img))
length = img.shape[0]
weith = img.shape[1]
print(img.shape)


# In[5]:


m = 3
expension_num = int((m-1)/2)
img1 = np.zeros((length+m-1,weith+m-1))
img1_final = img1
img1[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
for i in range(expension_num,length+expension_num):
    for j in range(expension_num,weith+expension_num):
        temp = 0
        for x in range(i-expension_num,i+expension_num+1):
            for y in range(j-expension_num,j+expension_num+1):
                temp = temp + img1[x,y]
        img1_final[i,j] = temp/(m**2)

plt.imshow(img1_final,'gray')


# In[6]:


m = 5
expension_num = int((m-1)/2)
img2 = np.zeros((length+m-1,weith+m-1))
img2_final = img2
img2[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
for i in range(expension_num,length+expension_num):
    for j in range(expension_num,weith+expension_num):
        temp = 0
        for x in range(i-expension_num,i+expension_num+1):
            for y in range(j-expension_num,j+expension_num+1):
                temp = temp + img2[x,y]
        img2_final[i,j] = temp/(m**2)

plt.imshow(img2_final,'gray')


# In[24]:


m = 9
expension_num = int((m-1)/2)
img3 = np.zeros((length+m-1,weith+m-1))
img3_final = img3
img3[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
for i in range(expension_num,length+expension_num):
    for j in range(expension_num,weith+expension_num):
        temp = 0
        for x in range(i-expension_num,i+expension_num+1):
            for y in range(j-expension_num,j+expension_num+1):
                temp = temp + img3[x,y]
        img3_final[i,j] = temp/(m**2)

plt.imshow(img3_final[expension_num:(length+expension_num),expension_num:(weith+expension_num)],'gray')


# In[23]:


m = 15
expension_num = int((m-1)/2)
img4 = np.zeros((length+m-1,weith+m-1))
img4_final = img4
img4[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
for i in range(expension_num,length+expension_num):
    for j in range(expension_num,weith+expension_num):
        temp = 0
        for x in range(i-expension_num,i+expension_num+1):
            for y in range(j-expension_num,j+expension_num+1):
                temp = temp + img4[x,y]
        img4_final[i,j] = temp/(m**2)

plt.imshow(img4_final[expension_num:(length+expension_num),expension_num:(weith+expension_num)],'gray')


# In[22]:


m = 35
expension_num = int((m-1)/2)
img5 = np.zeros((length+m-1,weith+m-1))
img5_final = np.zeros((length+m-1,weith+m-1))
img5[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
for i in range(expension_num,length+expension_num):
    for j in range(expension_num,weith+expension_num):
        temp = 0
        for x in range(i-expension_num,i+expension_num):
            for y in range(j-expension_num,j+expension_num):
                temp = temp + img5[x,y]
        img5_final[i,j] = temp/(m**2)

plt.imshow(img5_final[expension_num:(length+expension_num),expension_num:(weith+expension_num)],'gray')


# In[21]:


# coding upgrading
m = 15
expension_num = int((m-1)/2)
img6 = np.zeros((length+m-1,weith+m-1))
img6_final = np.zeros((length+m-1,weith+m-1))
img6[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
temp_col = np.zeros(m)
for i in range(expension_num,length+expension_num):
    for j in range(expension_num,weith+expension_num):
        if j == expension_num:
            temp_col = temp_col * 0
            col = 0
            for y in range(j-expension_num,j+expension_num+1):
                for x in range(i-expension_num,i+expension_num+1):
                    temp_col[col] = temp_col[col] + img6[x,y]
                col += 1
            img6_final[i,j] = sum(temp_col)/(m**2)
        else:
            temp_col[0:m-1] = temp_col[1:m]
            temp_col[m-1] = 0
            for x in range(i-expension_num,i+expension_num+1):
                temp_col[m-1] = temp_col[m-1] + img6[x,j+expension_num]
            img6_final[i,j] = sum(temp_col)/(m**2)
plt.imshow(img6_final[expension_num:(length+expension_num),expension_num:(weith+expension_num)],'gray')


# In[20]:


m = 35
expension_num = int((m-1)/2)
img7 = np.zeros((length+m-1,weith+m-1))
img7_final = np.zeros((length+m-1,weith+m-1))
img7[expension_num:(length+expension_num),expension_num:(weith+expension_num)] = img
temp_col = np.zeros(m)
for i in range(expension_num,length+expension_num):
    for j in range(expension_num,weith+expension_num):
        if j == expension_num:
            temp = 0
            temp_col = temp_col * 0
            col = 0
            for y in range(j-expension_num,j+expension_num+1):
                for x in range(i-expension_num,i+expension_num+1):
                    temp_col[col] = temp_col[col] + img7[x,y]
                col += 1
            img7_final[i,j] = sum(temp_col)/(m**2)
        else:
            temp_col[0:m-1] = temp_col[1:m]
            temp_col[m-1] = 0
            for x in range(i-expension_num,i+expension_num+1):
                temp_col[m-1] = temp_col[m-1] + img7[x,j+expension_num]
            img7_final[i,j] = sum(temp_col)/(m**2)
plt.imshow(img7_final[expension_num:(length+expension_num),expension_num:(weith+expension_num)],'gray')

