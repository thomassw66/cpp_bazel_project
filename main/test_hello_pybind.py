import unittest 
import hello_pybind as m
import numpy as np 

if __name__ == "__main__":

    print(m.add(2, 3))

    # Create a Matrix object from a numpy array 
    x = m.Matrix(np.random.normal(size=(20, 4)))
    print(x)

    # Convert the Matrix back to a numpy array 
    npx = np.array(x)
    print(npx)

