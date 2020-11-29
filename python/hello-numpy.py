import numpy as np


def ma(data, ws):
    v = np.cumsum(np.insert(data,0,0))
    ma_v = (v[ws:]-v[:-ws]) /ws
    return ma_v
    

data=[1,2,3,4,5]
a=ma(data,2)
# x = np.array([1, 2, 3, 4])
x = [1, 2, 3, 4]
print(ma(x,2))
    
    


