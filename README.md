
<!-- README.md is generated from README.Rmd. Please edit that file -->

movmean
=======

<!-- badges: start -->

[![License](http://img.shields.io/badge/license-GPL%20%28%3E=%203%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-3.0.html)
<!-- badges: end -->

> 2020年CUG大气科学系  
> R、Python、Julia、Fortran、Rcpp混合编程模板

Assignment (10 points)
----------------------

选择任意一个你擅长的语言，在该repository的基础上，编写滑动平均函数，测试通过后github推送给我。

**主要步骤如下：**

1.  登陆github账户，fork此repository
2.  git clone 克隆的仓库链接
3.  编写函数，编写R语言接口
4.  devtools::load\_all()配合browser测试
5.  git commit提交到github，****commit message中写明学号和姓名****
6.  Pull request提交给我

**如何修改remote-url:**

``` bash
# change remote url
git remote set-url origin https://github.com/your_username/movmean
git push
```

Installation
------------

``` r
devtools::install_github("kongdd/movmean")
```

Benchmarks
----------

``` r
library(movmean)
x = c(NA, 1, 2, 3, 4, 5, Inf)
# answer = c(1, 1.5, 2, 3, 4, 4.5, 5)
x = c(rnorm(1000))
r_jl  <- movmean_julia(x, halfwin = 5)
#> Julia version 1.5.3 at location C:\PROGRA~1\Julia\JULIA1~1.3\bin will be used.
#> Loading setup script for JuliaCall...
#> Finish loading setup script for JuliaCall.

# 欲用此版本需安装Julia，Julia版本暂时不能考虑NA, Inf
# r_jl <- movmean_julia(x, halfwin = 1)
microbenchmark::microbenchmark(
  r_jl  <- movmean_julia(x, halfwin = 5),
  r_cpp <- movmean_rcpp(x, halfwin = 5),
  r_f90 <- movmean_f90(x, halfwin = 5L),
  r_r   <- movmean_r(x, halfwin = 5, na.rm = FALSE), # the version of wyxz
  r_py  <- movmean:::movmean_py(x, halfwin = 5L), 
  r_np  <- movmean_np(x, halfwin = 5L)
)
#> Unit: microseconds
#>                                             expr     min       lq      mean
#>            r_jl <- movmean_julia(x, halfwin = 5)    81.8   129.05   175.402
#>            r_cpp <- movmean_rcpp(x, halfwin = 5)    80.1    94.10   100.265
#>            r_f90 <- movmean_f90(x, halfwin = 5L)    21.5    36.70    51.808
#>  r_r <- movmean_r(x, halfwin = 5, na.rm = FALSE)  4553.6  4646.65  7528.842
#>    r_py <- movmean:::movmean_py(x, halfwin = 5L)  1350.7  1445.00  1542.813
#>              r_np <- movmean_np(x, halfwin = 5L) 10074.3 10578.60 11028.487
#>    median       uq      max neval
#>    191.00   210.70    309.9   100
#>    100.35   105.45    238.5   100
#>     50.95    55.70    641.4   100
#>   4715.00  4804.05 210040.2   100
#>   1530.35  1611.70   2164.7   100
#>  11047.55 11531.85  11913.7   100
```

Acknowledgements
----------------

Keep in mind that this repository is released under a GPL3 license,
which permits commercial use but requires that the source code (of
derivatives) is always open even if hosted as a web service.
