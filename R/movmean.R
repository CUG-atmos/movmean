#' @export
movmean_R <- function(x, halfwin) {
  n <- length(x)
  m <- halfwin    #halfwin为半窗长度
  win <- 2*m+1
  y <- vector()    #为返回值做准备
  for (i in 1:n){
    if (i<m+1){     #左边不满足m个
      ind <- (1:(i+m))
      y[i] <- sum(x[ind])/length(ind)
    }else if(m+1<=i&i<=n-m){  #左右均满足
      ind <- ((i-m):(i+m))
      y[i] <- sum(x[ind])/win
    }else{                    #右边不满足m个：i>(n-m)
      ind <- ((i-m):n)
      y[i] <- sum(x[ind])/length(ind)
    }
  }
  return(y)
}
