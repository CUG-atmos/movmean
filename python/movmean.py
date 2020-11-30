#This is a little function for moving average calculation in python.
def movmean(x,m): #x:array,m:length of half window.
    import numpy as np
    n=len(x)
    i=1
    y=np.zeros(n)
    while i<=n:
        if isinstance(m,int)==False:     #In order to check the type of m and make sure it's an int.
            print('Please input an integer as the value for m!!!')
            break
        if i<m+1:
            ind=np.arange(0,(i+m),1)
            if i+m>n:                    #For the reasonable result in case of a value of m which 
                ind=np.arange(0,n,1)     #makes i+m larger than n when i is smaller than m+1.
            y[i-1]=np.sum(x[ind])/len(ind)
        elif m+1<=i<=n-m:
            y[i-1]=np.sum(x[(i-1-m):(i+m)])/(2*m+1)
        elif i>n-m:
            ind=np.arange((i-m-1),n,1)
            y[i-1]=np.sum(x[ind])/len(ind)
        i+=1    
    return y

