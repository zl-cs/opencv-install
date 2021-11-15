#!/bin/bash
# Liang in 2021-11-13
# variables:
# version - the version of OpenCV to be installed
# dldir - the download directory of the opencv and opencv_contrib package

version=3.4.3
dldir=OpenCV

echo "--- Installing Dependencies ---"
source dependencies.sh

echo "--- Downloading OpenCV" $version
mkdir -p $dldir
cd $dldir
git clone git@github.com:opencv/opencv.git
git checkout $version
cd opencv

echo "--- Downloading OpenCV_contrib" $version
git clone git@github.com:opencv/opencv_contrib.git
cd opencv_contrib
git checkout $version
cd ..

echo "--- Installing OpenCV and OpenCV_contrib" $version
mkdir build
cd build
cmake -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON ..
make -j 4
sudo make install
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
echo "OpenCV" $version "ready to be used"







