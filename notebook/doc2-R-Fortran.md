------------------------------------------------------------------------

title: “R语言对接Fortran代码” author: “Dongdong Kong” date: “2020/12/05”
output: github\_document —

R语言对接Fortran代码
====================

为何要对接Fortran代码？（1）Fortran是当之无愧的性能之王，在本文的测试中可以看到
Fortran代码的效率是Rcpp的2倍，R语言的20倍。在for循环密集的代码中，fortran可以轻松
达到R语言的200倍；（2）很多古老的、但专业上通用的模型采用Fortran语言编写，翻译成
其他语言，人力所不能及。

为何对接到R语言？R语言代码简单，调试方便；准备模型的输入、输出数据便利；此外，R语言擅长
统计分析和作图。这些fortran难以企及。因此如果能对接Fortran代码到R语言，可以集二者
之所长，更高效率的使用模型和分析数据。

如何对接
========

新建R project，选择R package using devtools
-------------------------------------------

一般选择R
package对接Fortran代码，对接完成之后，不需要修改，直接适用于windows、Linux
和mac操作系统。

编写Fortran函数
---------------

在次之前，需要安装Rtools（建议安装4.0版本，不用修改默认安装路径，直接放在C盘，仅占
用1G左右空间，<a href="https://cran.r-project.org/bin/windows/Rtools/" class="uri">https://cran.r-project.org/bin/windows/Rtools/</a>）。

高级编程语言（如c、c++、Fortran）的代码应放在src文件夹。

> 注意：（1）Fortran代码中real需要声明为REAL(8)，因为R语言没有float类型的变量，否则会
> 导致不可预知的错误。（2）需要加上`bind(C, name="movmean_f90_")`，其中`name`一般取原函数名+"\_"，否则R语言无法调用。
> 这是规范，不需要理解原因。

``` fortran
! mo_movmean.f90
subroutine movmean_f90(x, halfwin, n, x_mov) bind(C, name="movmean_f90_")
    INTEGER, INTENT(IN) :: halfwin  
    INTEGER, INTENT(IN) :: n   
    REAL(8)   , dimension(n), intent(in) :: x
    REAL(8)   , dimension(n), intent(OUT) :: x_mov

    integer :: i_begin, i_end

    do i = 1, n
        i_begin = max(i - halfwin , 1)
        i_end = min(i + halfwin, n)
        x_mov(i) = sum(x(i_begin:i_end))/(i_end - i_begin + 1)
    end do
end
```

注册到dll文件
-------------

这一步相对较为复杂，每次只需要把这个模板拷贝过来即可。

在src文件夹，新建`register_routines.c`文件，写入以下内容：

``` c
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
// #include <stdlib.h> // for NULL

#define CALLDEF(name, n) {#name, (DL_FUNC) &name, n}

// // C functions
// extern SEXP _movmean_movmean_rcpp(SEXP, SEXP, SEXP);
// extern SEXP _movmean_multiply_f90(SEXP, SEXP);

// static const R_CallMethodDef CallEntries[] = {
//     {"_movmean_movmean_rcpp", (DL_FUNC)&_movmean_movmean_rcpp, 3},
//     {"_movmean_multiply_f90", (DL_FUNC)&_movmean_multiply_f90, 2},
//     {NULL, NULL, 0}};

// Fortran functions
extern void F77_NAME(movmean_f90)(void *, void *, void *, void *);

static const R_FortranMethodDef FortranEntries[] = {
    {"movmean_f", (DL_FUNC)&F77_NAME(movmean_f90), 4},
    {NULL, NULL, 0}};

void R_init_movmean(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, NULL, FortranEntries, NULL)
    R_useDynamicSymbols(dll, FALSE);
}
```

Sublime merge
=============

工具用的好，git的命令除了git push、git push，其他完全不需要记。
