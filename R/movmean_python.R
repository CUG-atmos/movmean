#' @export 
movmean_python <- function(x, halfwin) {

}


#' @importFrom reticulate source_python
init_python < - function(){
    env = parent.frame()
    # env = as.environment("package:ARdetection.Pan")
    file = system.file("python/ar_iden.py", package="ARdetection.Pan")
    source_python(file, env)
}
