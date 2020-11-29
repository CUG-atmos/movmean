#' @export 
movmean_f90 <- function(x, ws = NULL, mask = NULL, normalize = FALSE) {
    if (is.null(ws)) ws = rep(1.0, length(x))
    if (is.null(mask)) mask = is.na(x)
    
    ans <- .Fortran("wsum_vec", x, ws, mask, normalize, length(x))
    last(ans) # the last is the returned result
}
