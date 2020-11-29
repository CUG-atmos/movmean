#' @examples
#' x <- c(1, 2, 3, 4, 5)
#' r_r <- movmean_R(x, 2)
#' @rdname movmean
#' @export
movmean_r <- function(x, halfwin = 2L) {
  m <- halfwin
  n <- length(x)
  win <- 2*m+1
  y <- c()
  for(i in 1:n){
    if(i >= (m+1) & i <= (n-m)){
      y[i] <- sum(x[(i-m):(i+m)])/win
    }else if(i < (m+1)){
      ind <- 1:(i+m)
      y[i] <- sum(x[ind])/length(ind)
    }else if(i > (n-m)){
      ind <- (i-m):n
      y[i] <- sum(x[ind])/length(ind)
    }
  }
  y
}
