#include <RcppArmadillo.h>
// #include <Rcpp.h>
using namespace Rcpp;

//' movmean
//'
//' NA and Inf values in the yy will be ignored automatically.
//'
//' @param y A numeric vector.
//' @param halfwin Integer, half of moving window size
//' @param w Corresponding weights of yy, same long as yy.
//' @param SG_style If true, head and tail values will be in the style of SG
//' (more weights on the center point), else traditional moving mean style.
//'
//' @examples
//' x <- 1:100
//' x[50] <- NA; x[80] <- Inf
//' s1 <- movmean(x, 2, SG_style = TRUE)
//' s2 <- movmean(x, 2, SG_style = FALSE)
//' @export
// [[Rcpp::export]]
NumericVector movmean(
    const arma::colvec y,
    int halfwin = 1,
    Nullable<NumericVector> w = R_NilValue)
{
  int n = y.size();
  arma::colvec yy(y);

  int frame = halfwin*2 + 1;
  int d = 1;
  // Create vector filled with NA(R version)
  arma::colvec ma = yy * NA_REAL; //ma: moving average
  arma::colvec ww = arma::ones<arma::colvec>(n); // weights
  if (w.isNotNull()) {
    ww = as<arma::colvec>(w);
  }
  // check Inf and NA
  for (int i = 0; i < n; i++ ) {
    if (!Rcpp::traits::is_finite<REALSXP>(yy[i])){
      ww[i] = 0;
      yy[i] = 0.0; // missing value as zero
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
      if (Rcpp::traits::is_finite<REALSXP>(yy[j])) {
        n_i++;
        sum += yy[j];
        sum_w += ww[j];
        // sum += ww[k] * yy[j];
        // sum_wtNA += ww[k];
      }
    }
    if (sum_w > 0) ma[i] = sum/sum_w; // else NA_real_
  }

  return Rcpp::NumericVector(ma.begin(), ma.end());
}
