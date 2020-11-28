REAL*8 FUNCTION MULTIPLY (X, Y) !bind(C, name = "multiply_")
    REAL*8 X, Y
    MULTIPLY = X * Y
    RETURN
END
