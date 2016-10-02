# installing the necessary packages for python 3.5 and their libraries
sudo yum install python35 python35-virtualenv python35-pip
sudo yum install gcc gcc-c++ gcc-gfortran
sudo yum install numpy scipy python-matplotlib ipython python-pandas sympy python-nose atlas-devel #
 install libraries v2.7, seems to be necessary for scipy version 3.5 from pip..

# installing libraries for python 3.5
sudo pip-3.5 install numpy # works, but takes a while
sudo pip-3.5 install pandas # works (after installing gcc-c++)
sudo pip-3.5 install scipy # works after installing the 2.7 scipy pack via sudo yum
sudo pip-3.5 install matplotlib 
sudo pip-3.5 install sklearn # requires scipy
sudo pip-3.5 install os
