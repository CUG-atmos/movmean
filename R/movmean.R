#' @export
movmean_R <- function(x, halfwin) {
  m <- halfwin
  win <- 2*m+1
  y <- vector()
  for (i in 1:n){
    if (i<(m+1)){
      ind <- (1:(i+m))
      y[i] <- sum(x[ind])/length(ind)
    }else if(m+1<=i<=n-m){
      y[i] <- sum(x[i-m:i+m])/win
    }else{
      ind <- (i-m:n)
      y[i] <- sum(x[ind])/length(ind)
    }
  }
  return(y)
}
