env <- list2env(list(.julia = FALSE))

julia_setup <- function() {
    JuliaCall::julia_setup()
    infile <- system.file("julia/movmean.jl", package = "movmean")
    # print(infile)
    # JuliaCall::julia_library("SpatioTemporalCluster")
    JuliaCall::julia_source(infile)
}


#' @importFrom JuliaCall julia_setup julia_source julia_call
julia_init <- function() {
    if (!env$.julia) {
        env$.julia <- TRUE
        julia_setup()
    }
}


#' @rdname movmean
#' @export
movmean_julia <- function(x, halfwin = 1L) {
    julia_init()
    julia_call("movmean", x, as.integer(halfwin))
}
