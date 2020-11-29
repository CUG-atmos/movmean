#! /usr/bin/Rscript
devtools::load_all()

x = (1:100)*1.0
y = movmean_f90(x)
print(y)
