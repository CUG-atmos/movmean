# -*- coding: utf-8 -*-
"""
Created on Sun Nov 29 19:15:44 2020

@author: lcx
"""
# %%
import numpy as np


def movmean_py(x, half_win = 1):
    '''           
    x = np.array([1,4,5,9,2,3,4])
    movmean_python(x,2)   #函数检验         
    '''
    m = half_win
    win = 2*m+1
    n = len(x)
    y = np.zeros(n)
    for i in range(0,n):
        if i < m:
            ind = np.arange(i+m+1)
            y[i] = sum(x[ind])/len(x[ind])
        elif i >= m and i <=(n-m-1):
            ind = np.arange((i-m),(i+m+1))
            y[i] = sum(x[ind])/win
        else:
            ind = np.arange((i-m),n)
            y[i] = sum(x[ind])/len(x[ind])
    return y


# if __name__ == "__main__":
#     x = np.array([1, 2, 3, 4])
#     r = movmean_py(x, 1)
#     print(r)


# %%
