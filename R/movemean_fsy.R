#2202010157fsy 2020.11.30
movemean <- function(x, i, m, na.rm = TRUE){
  n <- length(x)
  for(i in m:n){
    i_begin <- i-m+1
    i_end <- i
    y[i-m+1] <- mean(x[i_begin:i_end])
  }
  return(y)
}


# x <- 1:20
# movemean(x = x, m = 3)
