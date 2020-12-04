def movmean(x,m): 
    import numpy as np
    n=len(x)
    i=1
    y=np.zeros(n)
    for i in range(1,n+1):
        if i<m+1:
            ind=np.arange(0,(i+m),1)
            if i+m>n:                    
                ind=np.arange(0,n,1)     
            y[i-1]=np.sum(x[ind])/len(ind)
        if m+1<=i<=n-m:
            y[i-1]=np.sum(x[(i-1-m):(i+m)])/(2*m+1)
        if i>n-m:
            ind=np.arange((i-m-1),n,1)
            y[i-1]=np.sum(x[ind])/len(ind)
           
    return y
#movmean(x,2)
#Out[16]: array([2. , 2.5, 3. , 3.5, 4. ])
