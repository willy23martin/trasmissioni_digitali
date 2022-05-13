import timeit
import numpy as numpy

MATRIX_A = numpy.random.randn(100,100)
MATRIX_B = numpy.random.randn(100,100)

timeit.timeit('MATRIX_A@MATRIX_B') # @ - Matrix multiplication

def matrix_multiplication(MATRIX_A, MATRIX_B):
    MATRIX_MULTIPLICATION = numpy.zeros(MATRIX_A.shape)
    for dimension1 in range(100):
        for dimension2 in range(100):
            for dimension3 in range(100):
                MATRIX_MULTIPLICATION[dimension1, dimension2] += MATRIX_A[dimension1, dimension3]*MATRIX_B[dimension3, dimension2]
    return MATRIX_MULTIPLICATION

timeit.timeit('matrix_multiplication(MATRIX_A, MATRIX_B)')


