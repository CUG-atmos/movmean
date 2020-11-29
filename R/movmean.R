#' @export
movmean_R <- function(x, halfwin) {
  m <- halfwin
  win <- 2*m+1

  for i in range(1,n+1):
    if (i<m+1):
    ind=range(i+m)
  y.append(sum(x[0:i+m])/len(ind))
  elif (m+1<=i<=n-m):
    y.append(sum(x[i-m-1:i+m])/win)
  else:
    ind=range(i-m-1,n)
  y.append(sum(x[i-m-1:n])/len(ind))
  return y
}
