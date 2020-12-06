import numpy as np
def smooth(data, wsg):
  cumsum_vec = np.cumsum(np.insert(data, 0, 0)) 
  a_vec = (cumsum_vec[wsg:] - cumsum_vec[:-wsg]) / wsg
  return a_vec

data=[1,2,3,4,5,6,7]
test=smooth(data,2)
print(smooth(data, 2))
