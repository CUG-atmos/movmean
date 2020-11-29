#' @examples
#' x <- c(1, 2, 3, 4, 5)
#' r_r <- movmean_R(x, 2)
#' @rdname movmean
#' @export
movmean_r <- function(x, halfwin = 2L, na.rm = TRUE) {
  m <- halfwin
  n <- length(x)
  y <- rep(NA_real_, n)
  for (i in 1:n) {
    i_begin <- pmin(i - m, 1)
    i_end   <- pmax(i + m, n)
    y[i] <- mean(x[i_begin:i_end], na.rm = na.rm)
  }
  y
}

# movmean_R函数检验
# x <- runif(100,50,100)
# movmean <- movmean_R(x,5)
# x1<-1:100
# plot(x1,x,type='o')#未滑动平均数据
# plot(x1,movmean,type='o')#滑动平均后数据
