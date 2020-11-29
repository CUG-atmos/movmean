#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
#' @useDynLib movmean, .registration = TRUE
#' @importFrom Rcpp sourceCpp
## usethis namespace: end
NULL



#' @title moving average
#' @name movmean
#' 
#' @description moving average
#' 
#' @param x a numeric vector
#' @param halfwin integer, half size of the moving windows
NULL


.onLoad <- function(libname, pkgname) {
    python_init()
    # julia_init()
}
