import numpy as np

#ws为窗口宽度
def ma(data, ws):
    v = np.cumsum(np.insert(data,0,0))
    ma_v = (v[ws:]-v[:-ws]) /ws
    return ma_v
    


# x = np.array([1, 2, 3, 4])
x = [1, 2, 3, 4]
print(ma(x,2))
    
    


