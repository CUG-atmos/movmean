import numpy as np


def movmean_py_np(x, half_win=1):
    '''
    moving mean in numpy
            
    x = np.array([1,4,5,9,2,3,4])
    movmean_python(x,2)   #函数检验   

    By: Li Chenxi
    '''
    m = half_win
    win = 2*m+1
    n = len(x)
    y = np.zeros(n)
    for i in range(0, n):
        if i < m:
            ind = np.arange(i+m+1)
            y[i] = sum(x[ind])/len(x[ind])
        elif i >= m and i <= (n-m-1):
            ind = np.arange((i-m), (i+m+1))
            y[i] = sum(x[ind])/win
        else:
            ind = np.arange((i-m), n)
            y[i] = sum(x[ind])/len(x[ind])
    return y


def movmean_py(x, halfwin=1):
    """
    moving mean in Python array

    By: 赵雨欣子
    """
    m = halfwin
    win = m*2 + 1
    n = len(x)
    y = np.zeros(n)
    for i in range(n):
        if m <= i < (n-m):
          y[i] = sum(x[(i-m):(i+m+1)])/win
        if (i < m):
          y[i] = sum(x[0:(m+i+1)])/len(x[0:(m+i+1)])
        if i >= n-m:
          y[i] = sum(x[(i-m):n])/len(x[(i-m):n])
    return y

# if __name__ == "__main__":
#     movmean()
# x = np.array([1, 2, 3, 4])
# x = [1, 2, 3, 4]
# print(x[1])

