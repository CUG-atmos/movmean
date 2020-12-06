def movmean(x,m): 
    import numpy as np
    n=len(x)
    y=np.zeros(n)
    for i in range(0,n):
        if i<m:
            ind=np.arange(0,(i+m)+1)
            if i+m>n-1:                   
                ind=np.arange(0,n,1)   
            y[i]=np.sum(x[ind])/len(ind)
        elif m<=i<=n-m+1:
            y[i]=np.sum(x[(i-m):(i+m)+1])/(2*m+1)
        elif i>n-m:
            ind=np.arange((i-m-1),n)
            y[i]=np.sum(x[ind])/len(ind)    
    return y
