#' @export
movmean_R <- function(x, halfwin) {
  win<-2*halfwin+1
  movmean<-vector(mode = 'numeric',length = length(x))
  for (i in 1:length(x)){
    if(i<halfwin+1){
      ind<-1:(i+halfwin)
      movmean[i]<-sum(x[ind])/length(ind)
    }else if(i>=halfwin+1&i<=(length(x)-halfwin)){
      movmean[i]<-sum(x[(i-halfwin):(i+halfwin)])/win
    }else if(i>length(x)-halfwin){
      ind<-(i-halfwin):win
      movmean[i]<-sum(x[ind])/length(ind)
    }
  }
  return(movmean)
}
