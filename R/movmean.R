#' @export
movmean_R <- function(x,n) { #n=halfwin
  len <- length(x)
  each.mean <- numeric()     #restore mean value of each movement
  for( i in 1:length(x)){
    if(n+1 <= i <= len-n){
      ind <- (i-n):(i+n)
      each.mean[length(each.mean)+1] <- mean(x[ind])
    }
    if( i < (n+1) ){
      ind <- 1:(i+n)
      each.mean[length(each.mean)+1] <- mean(x[ind])
    }
    if( i > (len-n)){
      ind <- (i-n):len
      each.mean[length(each.mean)+1] <- mean(x[ind])
    }
  }
  movmean <- mean(each.mean)
  return(movmean)
}
