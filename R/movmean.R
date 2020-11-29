#' @export
movmean_R <- function(x, halfwin){
  n<-length(x)
  m<-halfwin
  win<-2*m+1
  r<-vector()
  for (i in 1:n) {
    if(i>=m&i<=n){
      inds<-(i-m):(i+m)
      r[i]<-x[inds]/win
    }
    if(i<m+1){
      inds<-1:(i+m)
      r[i]<-sum(x[inds])/length(inds)
    }
    if(i>n-m){
      inds<-(i-m):n
      r[i]<-sum(x[inds])/length(inds)
    }
  }
  return(r)
}
