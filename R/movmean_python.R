#' @examples
#'
#' movmean_python(x=1:5,1)
#' @rdname movmean
#' @export
movmean_np <- function(x, halfwin) {
    movmean_py_np(as.matrix(x), as.integer(halfwin))
}


#' @importFrom reticulate source_python
python_init <- function(){
    # env = parent.frame()
    env = environment(.onLoad)
    file = system.file("python/movmean.py", package="movmean")
    # file = "python/movmean.py"
    #browser()
    reticulate::source_python(file, env)
}
