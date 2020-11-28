#include <Rcpp.h>
using namespace Rcpp;


extern "C" double multiply_(double *x, double *y);
extern "C" double wsum_vec_(SEXP, SEXP, SEXP, SEXP);

// [[Rcpp::export]]
double multiply_f90(double x, double y)
{
    return multiply_(&x, &y);
}

// // [[Rcpp::export]]
// double wsum_vec_f90(NumericVector mat, NumericVector ws, LogicalVector mask,
//                     bool normalize = false)
// {
//     return wsum_vec_(wrap(mat), wrap(ws), wrap(mask), wrap(normalize));
// }
