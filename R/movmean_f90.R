#' @export 
movmean_f90 <- function(x, halfwin = 1L) {
    # if (is.null(ws)) ws = rep(1.0, length(x))
    # if (is.null(mask)) mask = is.na(x)
    y = rep(-9999.0, length(x))
    ans <- .Fortran("movmean_f", x, halfwin, length(x), y)
    # print(str(ans))
    last(ans)[[1]] # the last is the returned result
}
