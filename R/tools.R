# return the last n element
last <- function(x, n = 1) {
    len <- length(x)
    if ((len - n) < 1) {
        return(x)
    } else {
        x[seq(len - n + 1, len)]
    }
}
