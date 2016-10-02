
# setting up python

# installing the necessary packages for python 3.5 and their libraries
sudo yum install python35 python35-virtualenv python35-pip
sudo yum install gcc gcc-c++ gcc-gfortran
sudo yum install lapack-devel blas-devel atlas-devel 
sudo yum install libpng-devel freetype freetype-devel # for matplotlib
sudo yum install libtiff-devel libjpeg-devel libzip-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel # for pillow
#sudo yum install numpy scipy python-matplotlib ipython python-pandas sympy python-nose atlas-devel # install libraries v2.7, seems to be necessary for scipy version 3.5 from pip..

# installing libraries for python 3.5
# before installing scipy, create swap memory
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1

sudo pip-3.5 install scipy

sudo swapoff /var/swap.1
sudo rm /var/swap.1

# continue installing libraries
sudo pip-3.5 install numpy # works, but takes a while
sudo pip-3.5 install pandas # works (after installing gcc-c++)

# matplotlib requires freetype
# this might be unnecessary with sudo yum install freetype-devel, did not check yet
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.7.tar.gz
tar xzvf freetype-2.7.tar.gz
cd freetype-2.7
./configure
make
sudo make install

sudo pip-3.5 install matplotlib
sudo pip-3.5 install sklearn 
sudo pip-3.5 install sympy 
sudo pip-3.5 install pillow 
sudo pip-3.5 install twitter

pip-3.5 freeze
