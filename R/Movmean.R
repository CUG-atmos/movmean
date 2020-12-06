require(smooth)
require(Mcomp)
sma(M3$N2457$x, h=18, silent=FALSE)
sma(M3$N2568$x, h=18, interval=TRUE)
x <- c(1,3,6,10,20,22,16,12,18,24,42,8,16,15)
x <- data.frame(x)
colnames(x) <- "pm"
mav <- function(x,n=5){stats::filter(x,rep(1/n,n), sides=1)}
mav(x,1)
mav(x,2)
mav(x,3)
mav(x,4)
mav(x,5)
