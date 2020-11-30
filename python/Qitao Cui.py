import numpy as np
def movemean(x,halfwin):
    n=len(x)
    if halfwin>n/2:
        return print("错误！！！半窗长度过长！！！")
        
    y=np.zeros(n)
    if halfwin==1:
        y[0]=(x[0]+x[1])/2
        for i in range(1,n-1):
            y[i]=(x[i]+x[i-1]+x[i+1])/3
            y[n-1]=(x[n-2]+x[n-1])/2
    else:
        m=halfwin
        for i in range(0,n):
            if i<m:
                inds=np.arange(0,(i+m)+1)
                y[i]=(np.sum(x[inds]))/len(inds)
            elif i>=m and i<=n-m-1:
                y[i]=(np.sum(x[i-m:i+m+1]))/(2*m+1)
            else:
                inds=np.arange(i-m,n)
                y[i]=(np.sum(x[inds]))/len(inds)
    return y
#x=np.array([1,2,3,4,5])
#movemean(x, 2)
#Out: array([2. , 2.5, 3. , 3.5, 4. ])
