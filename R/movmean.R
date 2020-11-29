#' @export
movmean_R <- function(x, halfwin) {

  m<-halfwin
  n<-length(x)
  win<-2*m+1
  Y<-c()
  for(i in 1:n){
    if(i>=(m+1)&i<=(n-m)){
      Y[i]<-sum(x[(i-m):(i+m)])/win
    }else if(i<(m+1)){
      ind<-1:(i+m)
      Y[i]<-sum(x[ind])/length(ind)
    }else if(i>(n-m)){
      ind<-(i-m):n
      Y[i]<-sum(x[ind])/length(ind)
    }
  }
  return(Y)
}

x<-c(7,3,5,8,9,8,4,5,7,6,10,7,7,9,10,9,9,5,1,3,0,-2,1,1,2,1,-1,-2,4,5)
x.movmean<-movmean_R(x,halfwin=2)
length(x)
xy<-1:30
Y<-x.movmean

library(ggplot2)
plot(xy,x,type = "o")
plot(xy,Y,type = "o")

