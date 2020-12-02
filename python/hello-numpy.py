import numpy as np
def movemean(x,halfwin):
    n=len(x)
    p=np.zeros(n)
    a=[float(np.inf),float(-np.inf)]
    if halfwin>n/2 or halfwin in a:
        return print("error:halfwin is too long.")
    elif halfwin==np.NAN:
         print('error:halfwin is NAN')
    elif halfwin==1:
        p[0]=(p[0]+p[1])/2
        for i in range(1,n-1):
            p[i]=(p[i]+p[i-1]+p[i+1])/3
            p[n-1]=(p[n-2]+p[n-1])/2
    else:
        m=halfwin
        for i in range(0,n):
            if i<m:
                inds=np.arange(0,(i+m)+1)
                p[i]=(np.sum(x[inds]))/len(inds)
            elif i>=m and i<=n-m-1:
                p[i]=(np.sum(x[i-m:i+m+1]))/(2*m+1)
            else:
                inds=np.arange(i-m,n)
                p[i]=(np.sum(x[inds]))/len(inds)
    return p

    
    


