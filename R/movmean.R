#' @export
movmean_R <- function(x, halfwin) {
  m<-halfwin
  n<-length(x)
  win<-2*m+1
  r<-vector()
  for(i in 1:n){
    if(i<=n-m&i>=m+1){
      ind<-(i-m):(i+m)
      r[i]<-sum(x[ind])/win
    }
    if(i<m+1){
      ind<-i:(i+m)
      r[i]<-sum(x[ind])/length(ind)
    }
    if(i>n-m){
      ind<-(i-m):n
      r[i]<-sum(x[ind])/length(ind)
    }
  }
  return(r)
}
