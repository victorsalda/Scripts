###**Victor D. Saldaña C.**
######PhD(c) in Geoinformatics Engineering
######Technical University of Madrid (Spain)
######LinkedIn: https://es.linkedin.com/in/victorsalda
######Github: https://github.com/victorsalda
######Rpubs: http://rpubs.com/victorsalda
######email: victorsalda@hotmail.com
######*December, 2016*

# File encoding.
# -*- coding: utf-8 -*-

# Import packages.
import os as os # operating system dependent functionality.
import csv as csv # reading and writing of Comma Separated Value (CSV).
import pandas as pd #data structures & analysis.
import scipy as sp #scientific computing (optimization, linear algebra, FFT, DIP, etc.).
import numpy as np #multi-dimensional arrays and matrices and mathematical functions.
import matplotlib as plt #2D plotting.
import sklearn as sklearn #machine learning.
import sympy as sympy #symbolic mathematics.
import nltk as nltk #natural language processing.
import seaborn as seaborn #statistical data visualization.
import plotly as plotly #online analytics and visualization.

#Use type to return the object's type.
type("This is a string")
type(None)
type(1)
type(1.0)
type(add_numbers)

#Data structure.
#Tuples are an immutable data structure (cannot be altered).
x = (1, "a", 2, "b")
type(x)

#Lists are a mutable data structure.
y = [1, "a", 2, "b"]
type(y)

# Use "append" to append an object to a list.
y.append(3.3)
print(y)

# Use "+" to concatenate lists.
y=[1,2] + [3,4]
print(y)

# Use "*" to repeat lists.
y=[2,3]*3
print(y)

# Use the "in" operator to check if something is inside a list.
5 in [1, 2, 3]

# Now let's look at strings. Use bracket notation to slice a string.
x = "This is a string"
print(x[0]) #first character
print(x[0:1]) #first character, but we have explicitly set the end character
print(x[0:2]) #first two characters

# This will return the last element of the string.
x[-1]

# This will return the slice starting from the 4th element from the end and stopping before the 2nd element from the end.
x[-4:-2]

# This is a slice from the beginning of the string and stopping before the 3rd element.
x[:3]

# And this is a slice starting from the 3rd element of the string and going all the way to the end.
x[3:]

#More on string.
firstname = "Christopher"
lastname = "Brooks"
print(firstname + " " + lastname)
print((firstname + " ")*3)
print("Chris" in firstname)

# "split" returns a list of all the words in a string, or a list split on a specific character.
firstname = "Christopher Arthur Hansen Brooks".split(" ")[0] # [0] selects the first element of the list
lastname = "Christopher Arthur Hansen Brooks".split(" ")[-1] # [-1] selects the last element of the list
print(firstname)
print(lastname)

# Make sure you convert objects to strings before concatenating.
print("Chris" + str(2))

# Dictionaries associate keys with values.
x = {"1": "brooksch@umich.edu", "Bill Gates": "billg@microsoft.com"}
x["1"]
x["Bill Gates"]
x["Kevyn Collins-Thompson"]=None
x["Kevyn Collins-Thompson"]

# Iterate over all of the keys:
for i in x:
    print(x[i])

# Iterate over all of the values:
for i in x.values():
    print(i)

# Iterate over all of the items in the list:
for i,j in x.items():
    print(i)
    print(j)

# You can unpack a sequence into different variables:
x = ("Christopher", "Brooks", "brooksch@umich.edu")
x = fname, lname, email

# Python has a built in method for convenient string formatting.
sales_record = {"price": 3.24, "num_items": 4, "person": "Chris"}
sales_statement = "{} bought {} item(s) at a price of {} each for a total of {}"
print(sales_statement.format(sales_record["person"],
                             sales_record["num_items"],
                             sales_record["price"],
                             sales_record["num_items"]*sales_record["price"]))

# Reading and Writing CSV files
os.chdir('C:\\Victor\\Estudios\\9_Data_Science_with_Python\\1_Introduction') #Directory file.

with open("mpg.csv","rb") as mpg_csv_open: #Open a file, returning an object of the file type.
    mpg_csv_read = csv.reader(mpg_csv_open) #Return a reader object which will iterate over lines in the given csvfile
    for i in mpg_csv_read:
        print (i)

mpg_csv_open = open("mpg.csv","rb")
mpg_csv_read = csv.reader(mpg_csv_open, delimiter=",") #Delimiter comma is the default (no necessary)
for i in mpg_csv_read:
    print (i)

#Escape characters
a="The question is, \"to be or not to be\""
print(a)
