#' @export 
movmean_R <- function(x, halfwin) {
  m <- halfwin
  win <- 2*m + 1
  n <- length(x)
  mmean <- vector("numeric",length = n)
  for (i in 1:n) {
    if(i < (m+1)){
      ind <- 1:(m+i)
      mmean[i] <- sum(x[ind])/length(ind)
    }else if(i >= (m + 1) & i <= (n-m)){
      ind <- (i-m):(i+m)
      mmean[i] <- sum(x[ind])/win
    }else if(i > (n-m)){
      ind <- (i-m):n
      mmean[i] <- sum(x[ind])/length(ind)
    }
  }
  return(mmean)
}
