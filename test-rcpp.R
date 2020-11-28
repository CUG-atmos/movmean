#! /usr/bin/Rscript
devtools::load_all()

x = (1:100)*1.0
y = wsum_vec2(x)
print(y)
