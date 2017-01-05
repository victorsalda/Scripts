# File encoding.
# -*- coding: utf-8 -*-

# **Victor D. Saldaña C.**
# PhD(c) in Geoinformatics Engineering
# Technical University of Madrid (Spain)
# LinkedIn: https://es.linkedin.com/in/victorsalda
# Github: https://github.com/victorsalda
# Rpubs: http://rpubs.com/victorsalda
# email: victorsalda@hotmail.com
# *December, 2016*

###############################################################################

# Import packages.
import os as os  # operating system dependent functionality.
import datetime as dt  # classes for manipulating dates and times.
import csv as csv  # reading and writing of Comma Separated Value (CSV).
import pandas as pd  # data structures & analysis.
import scipy as sp  # scientific computing(optimization, linear algebra, etc.).
import numpy as np  # arrays and matrices and mathematical functions.
import matplotlib as plt  # 2D plotting.
import sklearn as sklearn  # machine learning.
import sympy as sympy  # symbolic mathematics.
import nltk as nltk  # natural language processing.
import seaborn as seaborn  # statistical data visualization.
import plotly as plotly  # online analytics and visualization.

###############################################################################

# Use type to return the object's type.
type("This is a string")
type(None)
type(1)
type(1.0)
type((1, 2, "a", "f"))
type([1, 2, "a", "f"])

# Data structure.
# Tuples are an immutable data structure (cannot be altered).
x = (1, "a", 2, "b")
type(x)

# Lists are a mutable data structure.
y = [1, "a", 2, "b"]
type(y)

# Use "append" to append an object to a list.
y.append(3.3)
print(y)

# Use "+" to concatenate lists.
y = [1, 2] + [3, 4]
print(y)

# Use "*" to repeat lists.
y = [2, 3]*3
print(y)

# Use the "in" operator to check if something is inside a list.
5 in [1, 2, 3]


###############################################################################


# Now let's look at strings. Use bracket notation to slice a string.
x = "This is a string"
print(x[0])  # first character
print(x[0:1])  # first character, but we have explicitly set the end character
print(x[0:2])  # first two characters

# This will return the last element of the string.
x[-1]

# This will return the slice starting from the 4th element from the end and
# stopping before the 2nd element from the end.
x[-4:-2]

# This is a slice from the beginning of the string and stopping before the
# 3rd element.
x[:3]

# And this is a slice starting from the 3rd element of the string and going
# all the way to the end.
x[3:]

# More on string.

firstname = "Christopher"
lastname = "Brooks"
print(firstname + " " + lastname)
print((firstname + " ")*3)
print("Chris" in firstname)

# "split" returns a list of all the words in a string, or a list split on a
# specific character.

# [0] selects the first element of the list
firstname = "Christopher Arthur Hansen Brooks".split(" ")[0]

# [-1] selects the last element of the list
lastname = "Christopher Arthur Hansen Brooks".split(" ")[-1]
print(firstname)
print(lastname)

# Make sure you convert objects to strings before concatenating.
print("Chris" + str(2))

# Dictionaries associate keys with values.
x = {"1": "brooksch@umich.edu", "Bill Gates": "billg@microsoft.com"}
x["1"]
x["Bill Gates"]
x["Kevyn Collins-Thompson"] = None
x["Kevyn Collins-Thompson"]

# Iterate over all of the keys:
for i in x:
    print(x[i])

# Iterate over all of the values:
for i in x.values():
    print(i)

# Iterate over all of the items in the list:
for i, j in x.items():
    print(i)
    print(j)

# You can unpack a sequence into different variables:
x = ("Christopher", "Brooks", "brooksch@umich.edu")
x = fname, lname, email

# Python has a built in method for convenient string formatting.
sales_record = {"price": 3.24, "num_items": 4, "person": "Chris"}
sales_statement = "{} bought {} item(s) at a price of {} each.Total of {}"
print(sales_statement.format(sales_record["person"],
                             sales_record["num_items"],
                             sales_record["price"],
                             sales_record["num_items"]*sales_record["price"]))

# Escape characters.
a = "The question is, \"to be or not to be\""
print(a)


###############################################################################


# # Reading and Writing CSV files.
# Directory file.
os.chdir('C:\\Victor\\Estudios\\9_Data_Science_with_Python\\1_Introduction')

# Open a file, returning an object of the file type.
with open("mpg.csv", "rb") as mpg_csv_open:
    # Return a reader object. It will iterate over lines in the given csvfile.
    mpg_csv_read = csv.reader(mpg_csv_open)
    for i in mpg_csv_read:
        print (i)

mpg_csv_open = open("mpg.csv", "rb")

# Delimiter comma is the default (no necessary).
mpg_csv_read = csv.reader(mpg_csv_open, delimiter=",")
for i in mpg_csv_read:
    print (i)

###############################################################################

# # Handy datetime attributes:

# "date.today" returns the current local date.
dt.date.today()

# Create a timedelta of 100 days.
dt.timedelta(days=100)
dt.date.today()-dt.timedelta(days=100)


###############################################################################
class Person:
    department = "School of Information"    # a class`s variable (attribute,
                                            # shared by all instances).

    def set_name(self, new_name):  # a class's method (function)
        self.name = new_name      # variable unique to each instance.
                                  # self is a variable and the name self
                                  # is just a convention. new name is an
                                  # attribute.

    def set_location(self, new_location):
        self.location = new_location

person = Person()
person.set_name("Christopher Brooks")
person.set_location("Ann Arbor, MI, USA")
print("{} live in {} and works in the department {}".format(person.name,
                                                            person.location,
                                                            person.department))

class Person:
    department = "School of Information"  # a class`s variable (attribute,
                                          # shared by all instances).

    def __init__(self, new_name, new_location):  # a class's method (function)
        self.name = new_name      # variable unique to each instance.
        self.location = new_location  # self is a variable and the name self
                                  # is just a convention. new name is an
                                  # attribute.

a = Person("Pepe", "Madrid")
a.department
a.name
a.location
print("{} live in {} and works in the department {}".format(a.name,
                                                            a.location,
                                                            a.department))
###############################################################################

# Here's an example of mapping the "min" function between two lists.
store1 = [1, 2, 3, 9]
store2 = [1, 6, 2, 8]
cheapest = map(min, store1, store2)
cheapest

# Now let's iterate through the map object to see the values.
for i in cheapest:
    print(i)

# Here's an example of lambda that takes in three parameters and
# adds the first two.
my_function = lambda a, b, c: a + b


def my_function(a, b, c):
    return a + b

my_function(1, 2, 3)

# Let's iterate from 0 to 99 and return the even numbers.
my_list = []

for number in range(0, 20):
    if number % 2 == 0:  # % module arguement.
        my_list.append(number)
my_list

# Now the same thing but with list comprehension.
my_list = [number for number in range(0, 20) if number % 2 == 0]
my_list

###############################################################################

# # Numerical Python (NumPy).

# Create a list and convert it to a numpy array
mylist = [1, 2, 3]
x = np.array(mylist)
x

# Or just pass in a list directly
y = np.array([4, 5, 6])
y

# Pass in a list of lists to create a multidimensional array.
m = np.array([[7, 8, 9], [10, 11, 12]])
m

# Use the shape method to find the dimensions of the array. (rows, columns)
m.shape

# "arange" returns evenly spaced values within a given interval.
n = np.arange(0, 30, 5)  # start at 0 count up by 2, stop before 30
n

# "reshape" returns an array with the same data with a new shape.
n = n.reshape(3, 2)  # reshape array to be 3x5
n

# "linspace" returns evenly spaced numbers over a specified interval.

o = np.linspace(0, 4, 9)  # return 9 evenly spaced values from 0 to 4
o

# "resize" changes the shape and size of array in-place.
o.resize(3, 3)
o

# "ones" returns a new array of given shape and type, filled with ones.
np.ones((3, 2))

# "zeros" returns a new array of given shape and type, filled with zeros.
np.zeros((2, 3))

# "eye" returns a 2-D array with ones on the diagonal and zeros elsewhere.
np.eye(3)

# "diag" extracts a diagonal or constructs a diagonal array.
y = np.array([4, 5, 6])
np.diag(y)

# Create an array using repeating list (or see `np.tile`)
np.array([1, 2, 3] * 3)

# Repeat elements of an array using "repeat".
np.repeat([1, 2, 3], 3)

# Combining Arrays
p = np.ones([2, 3], int)
p

# Use "vstack" to stack arrays in sequence vertically (row wise).
np.vstack([p, 2*p])
p

# Use "hstack" to stack arrays in sequence horizontally (column wise).
np.hstack([p, 2*p])

# Operations.

# Use "+", "-", "*", "/" and "**" to perform element wise addition,
# subtraction, multiplication, division and power.
print(x + y)  # elementwise addition [1 2 3] + [4 5 6] = [5  7  9]
print(x - y)  # elementwise subtraction [1 2 3] - [4 5 6] = [-3 -3 -3]
print(x * y)  # elementwise multiplication [1 2 3] * [4 5 6] = [4  10  18]
print(x / y)  # elementwise divison [1 2 3] / [4 5 6] = [0.25  0.4  0.5]
print(x**2)   # elementwise power  [1 2 3] ^2 =  [1 4 9]

# Dot product  1*4 + 2*5 + 3*6
x = np.array([1, 2, 3])
y = np.array([4, 5, 6])
x.dot(y)

# Number of rows of array.
z = np.array([y, y**2])
print(len(z))

# Let's look at transposing arrays. Transposing permutes the dimensions of
# the array.
z = np.array([y, y**2])
z

# The shape of array "z" is `(2,3)` before transposing.
z.shape
z.T

# The number of rows has swapped with the number of columns.
z.T.shape

# Use ".dtype" to see the data type of the elements in the array.
z.dtype

# Use ".astype" to cast to a specific type.
z = z.astype("f")
z.dtype

# Numpy has many built in math functions that can be performed on arrays.
a = np.array([-4, -2, 1, 3, 5])
a.sum()
a.max()
a.min()
a.mean()
a.std()

# "argmax" and "argmin" return the index of the maximum and minimum values
# in the array.
a.argmax()
a.argmin()

# Indexing / Slicing
s = np.arange(13)**2
s

# Use bracket notation to get the value at a specific index.
# Remember that indexing starts at 0.
s[0], s[4], s[-1]

# Use ":" to indicate a range. "array[start:stop]"
s[1:5]

# Use negatives to count from the back.
s[-4:]

# A second ":" can be used to indicate step-size. "array[start:stop:stepsize]"
# Here we are starting 5th element from the end, and counting backwards
# by 2 until the beginning of the array is reached.
s[-5::-2]

# Let's look at a multidimensional array.
r = np.arange(36)
r.resize((6, 6))
r

# Use bracket notation to slice: "array[row, column]".
r[2, 2] # index starts in 0.

# And use : to select a range of rows or columns
r[3, 3:6]

# Here we are selecting all the rows up to (and not including) row 2,
# and all the columns up to (and not including) the last column.
r[:2, :-1]

# This is a slice of the last row, and only every other element.
r[-1, ::2]

# We can also perform conditional indexing. Here we are selecting values from
# the array that are greater than 30. (Also see "np.where")
r[r > 30]

# Here we are assigning all values in the array that are greater than 30
# to the value of 30.
r[r > 30] = 30
r

# Copying Data
# Be careful with copying and modifying arrays in NumPy!
# "r2" is a slice of "r".
r2 = r[:3, :3]
r2

# Set this slice's values to zero ([:] selects the entire array)
# "r" has also will be been changed!
r2[:] = 0
r2
r
# To avoid this, use "r.copy" to create a copy that will not affect
# the original array.
r_copy = r.copy()
r_copy

# Now when r_copy is modified, r will not be changed.
r_copy[:] = 10
print(r_copy, "\n")
print(r)

# Iterating Over Arrays.
# Let's create a new 4 by 3 array of random numbers 0-9.
test = np.random.randint(0, 10, (4, 3))
test

# Iterate by row:
for row in test:
    print(row)

# Iterate by index:
for i in range(len(test)):
    print(test[i])

# Iterate by row and index:
for i, row in enumerate(test):
    print("row", i, "is", row)

# Use "zip" to iterate over multiple iterables.
test2 = test**2
test2

for i, j in zip(test, test2):
    print(i,"+",j,"=",i+j)

###############################################################################

# pandas.Series 
# One-dimensional ndarray with axis labels (including time series).

animals = ["Tiger", "Bear", "Moose"]
pd.Series(animals)

numbers = [1, 2, 3]
pd.Series(numbers)

animals = ["Tiger", "Bear", None]
pd.Series(animals)

numbers = [1, 2, None]
pd.Series(numbers)
