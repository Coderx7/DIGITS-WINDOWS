# DIGITS_WINDOWS

[![Build Status](https://travis-ci.org/NVIDIA/DIGITS.svg?branch=master)](https://travis-ci.org/NVIDIA/DIGITS)
[![Coverage Status](https://coveralls.io/repos/NVIDIA/DIGITS/badge.svg?branch=master)](https://coveralls.io/r/NVIDIA/DIGITS?branch=master)

DIGITS (the **D**eep Learning **G**PU **T**raining **S**ystem) is a webapp for training deep learning models.

# Installation

Note: For the latest instructions on how to make DIGITS run on windows visit : https://github.com/NVIDIA/DIGITS/blob/master/docs/BuildDigitsWindows.md

For Windows Installation Visit this issue : https://github.com/NVIDIA/DIGITS/issues/47#issuecomment-205427707
### Note: 
* You need to have the Microsoft branch of caffe installed. 
* You need to change two lines specifically and enter your own path to caffe executable . 
* You also need to have an environment variable called CAFFE_ROOT which poinst to the root of your caffe installation.
* Your PYTHONPATH environment variable needs as well to have a meaningful content (that is it needs to point to your python.exe)
* the PATH environment variable needs to have your caffe.exe path, your pycaffe folder as well. 
* when you install Anaconda, it will automatically configure path variable for python itself. 


These are however how my system is configured and DIGITS is running mostly well. I have no idea if any step above is unnecessary.
Hope this comes handy to some one. 
Seyyed Hossein Hasan Pour

Once you have installed DIGITS, visit [docs/GettingStarted.md](docs/GettingStarted.md) for an introductory walkthrough. 


# Get help

### Installation issues
* First, check out the instructions above
* Then, ask questions on our [user group](https://groups.google.com/d/forum/digits-users)

### Usage questions
* First, check out the [Getting Started](docs/GettingStarted.md) page
* Then, ask questions on our [user group](https://groups.google.com/d/forum/digits-users)

### Bugs and feature requests
* Please let us know by [filing a new issue](https://github.com/NVIDIA/DIGITS/issues/new)
* Bonus points if you want to contribute by opening a [pull request](https://help.github.com/articles/using-pull-requests/)!
  * You will need to send a signed copy of the [Contributor License Agreement](CLA) to digits@nvidia.com before your change can be accepted.

