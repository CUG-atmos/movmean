// // #include <RcppArmadillo.h>
// // #include <Rcpp.h>
// // using namespace Rcpp;
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
// #include <stdlib.h> // for NULL


#define CALLDEF(name, n) {#name, (DL_FUNC) &name, n}


// C functions
extern SEXP _movmean_movmean_rcpp(SEXP, SEXP, SEXP);
extern SEXP _movmean_multiply_f90(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_movmean_movmean_rcpp", (DL_FUNC)&_movmean_movmean_rcpp, 3},
    {"_movmean_multiply_f90", (DL_FUNC)&_movmean_multiply_f90, 2},
    {NULL, NULL, 0}};

// Fortran functions
extern void F77_NAME(wsum_vec)(void *, void *, void *, void *, void *);
extern void F77_NAME(movmean_f90)(void *, void *, void *, void *);

static const R_FortranMethodDef FortranEntries[] = {
    {"wsum_vec", (DL_FUNC)&F77_NAME(wsum_vec), 5},
    {"movmean_f", (DL_FUNC)&F77_NAME(movmean_f90), 4},
    {NULL, NULL, 0}};

void R_init_movmean(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, FortranEntries, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
