test_that("Rcpp works", {
  x = c(NA, 1, 2, 3, 4, 5, Inf)
  answer = c(1, 1.5, 2, 3, 4, 4.5, 5)

  r_cpp <- movmean_rcpp(x, 1)
  expect_equal(r_cpp, answer)
})
