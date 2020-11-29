#function
movmean_R <- function(x, halfwin) {
  m <- halfwin
  n <- length(x)
  win <- 2*m + 1
  movmean <- c()
  for(i in 1:n){
    if(i >= ( m + 1 ) & i <= ( n - m )){
      movmean[i] <- sum(x[( i - m ):( i + m )])/win
    }
    else if(i < ( m + 1 )){
      ind <- 1:( i + m )
      movmean[i] <- sum(x[ind])/length(ind)
    }
    else if(i > ( n - m )){
      ind <- ( i - m ):n
      movmean[i] <- sum(x[ind])/length(ind)
    }
  }
  movmean
}

#test

library(ggplot2)

x <- c(8,12,10,12,10,8,8,10,9,8,6,7,8,7,7,9,8,8,10,11,8,8,9,10,10,12,12,12)
y <- movmean_R(x,halfwin=2)
x1 <- 1:28
plot(x1,x,type = "o")

plot(x1,y,type = "o")
