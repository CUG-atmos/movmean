#include <RcppArmadillo.h>
// #include <Rcpp.h>
using namespace Rcpp;

//' @name movmean
//' @title moving average
//'
//' NA and Inf values in the xx will be ignored automatically.
//'
//' @param x A numeric vector.
//' @param halfwin Integer, half of moving window size
//' @param w Corresponding weights of xx, same long as yy.
//'
//' @examples
//' x <- 1:100
//' x[50] <- NA; x[80] <- Inf
//' s1 <- movmean_rcpp(x, 1)
//' s2 <- movmean_rcpp(x, 2)
//' @rdname movmean
//' @export
// [[Rcpp::export]]
NumericVector movmean_rcpp(
    const arma::colvec x,
    int halfwin = 1,
    Nullable<NumericVector> w = R_NilValue)
{
  int n = x.size();
  arma::colvec xx(x);

  // int frame = halfwin*2 + 1;
  // int d = 1;
  // Create vector filled with NA(R version)
  arma::colvec ma = xx * NA_REAL; //ma: moving average
  arma::colvec ww = arma::ones<arma::colvec>(n); // weights
  if (w.isNotNull()) {
    ww = as<arma::colvec>(w);
  }
  // check Inf and NA
  for (int i = 0; i < n; i++ ) {
    if (!Rcpp::traits::is_finite<REALSXP>(xx[i])){
      ww[i] = 0;
      xx[i] = 0.0; // missing value as zero
    }
  }

  // main script of moving average
  int i_begin, i_end, n_i;
  double sum, sum_w;
  for (int i = 0; i < n; i++){
    if (i < halfwin) {
      i_begin = 0;
      i_end = i + halfwin;
    } else if (i >= n - halfwin - 1) {
      i_begin = i - halfwin;
      i_end = n-1;
    } else {
      i_begin = i - halfwin;
      i_end = i + halfwin;
    }

    n_i   = 0; // number
    sum   = 0.0; // sum of values in window
    sum_w = 0.0; // sum of weights in window

    for (int j = i_begin; j <= i_end; j++) {
      if (Rcpp::traits::is_finite<REALSXP>(xx[j])) {
        n_i++;
        sum += xx[j];
        sum_w += ww[j];
        // sum += ww[k] * xx[j];
        // sum_wtNA += ww[k];
      }
    }
    if (sum_w > 0) ma[i] = sum/sum_w; // else NA_real_
  }

  return Rcpp::NumericVector(ma.begin(), ma.end());
}
