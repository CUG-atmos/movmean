#' @export
movmean_python <- function(x, halfwin) {

}


#' @importFrom reticulate source_python
python_init <- function(){
    # env = parent.frame()
    env = environment(.onLoad)
    file = system.file("python/movmean.py", package="movmean")
    # browser()
    reticulate::source_python(file, env)
}

.onLoad <- function(libname, pkgname) {
    python_init()
    julia_init()
}
