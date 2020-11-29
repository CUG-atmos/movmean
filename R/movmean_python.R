#' @examples
#'
#' movmean_python(x=1:5,1)
#' @rdname movmean
#' @export
movmean_np <- function(x, halfwin) {
    movmean_py_np(as.matrix(x), as.integer(halfwin))
}
