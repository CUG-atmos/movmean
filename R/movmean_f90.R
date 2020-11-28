
wsum_vec2 <- function(x, ws = NULL, mask = NULL, normalize = FALSE) {
    if (is.null(ws)) ws = rep(1.0, length(x))
    if (is.null(mask)) mask = is.na(x)

    print(mask)
    print(ws)

    .Fortran("wsum_vec", x, ws, mask, normalize, length(x))
}
# r <- .Fortran("droughtIndicator", mat, mask, threshold, 
#                   nrows, ncols, ntime, exceeding,
#                   cellCoor, SMIc)
