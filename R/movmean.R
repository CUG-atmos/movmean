movmean<-function(x,halfwin){
  n<-length(x)
  m<-halfwin
  win<-2*m+1
  r<-vector()
  for(i in 1:n){
    if(i<m+1)
      ind<-1:(i+m)
    r[i]<-sum(x[ind])/length(ind)
    if(m+1<=i&i<=n-m)
      ind<-(i-m):(i+m)
    r[i]<-sum(x[ind])/win
    if(i>n-m)
      ind<-(i-m):n
    r[i]<-sum(x[ind])/length(ind)
  }
  return(r)
}
