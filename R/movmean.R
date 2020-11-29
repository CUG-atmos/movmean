#' @export
movmean_R <- function(x, halfwin){
m<-halfwin
n<-length(x)
window<-2*m+1
r<-vector()
for(i in 1:n){
  if(i>=(m+1)&i<=(n-m)){
    ind<-(i-m):(i+m)
    r[i]<-sum(x[ind])/window
}
else if(i<(m+1)){
   ind<-1:(i+m)
   r[i]<-sum(x[ind])/length(ind)
}
else if(i>(n-m)){
   ind<-(i-m):n
   r[i]<-sum(x[ind])/length(ind)
}
}
r
}

#movmean_R函数检验
x <- runif(100,50,100)
movmean <- movmean_R(x,5)
x1<-1:100
plot(x1,x,type='o')#未滑动平均数据
plot(x1,movmean,type='o')#滑动平均后数据



