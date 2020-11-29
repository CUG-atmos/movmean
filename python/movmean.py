import numpy as np

def movmean(x,halfwin):
    m = halfwin
    win = m*2 + 1
    n = len(x)
    y = np.zeros(n)
    for i in range(n):
        if m<= i < (n-m):
          y[i] = sum(x[(i-m):(i+m+1)])/win
        if (i < m):
          y[i] = sum(x[0:(m+i+1)])/len(x[0:(m+i+1)])
        if i >= n-m:
          y[i] = sum(x[(i-m):n])/len(x[(i-m):n])
    return y
'''
eg:
print(movmean([2,4,1,5,7,8],2))
[2.33333333 3. 3.8  5. 5.25 6.66666667]
print(movmean([1,3,5,6,7,8,9,5,4,2,2],1))
[2. 3. 4.66666667 6. 7. 8. 7.33333333 6. 3.66666667 2.66666667 2. ]
'''