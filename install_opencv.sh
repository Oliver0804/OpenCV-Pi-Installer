#!/bin/bash
set -e


# 檢查 /sbin/dphys-swapfile 中 CONF_MAXSWAP=2048 是否存在
if grep -q "CONF_MAXSWAP=2048" /etc/dphys-swapfile; then
    echo "發現系統設置的swap大小為2048MB，您是否希望將其改為4096MB? (y/n)"
    read response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo sed -i 's/CONF_MAXSWAP=2048/CONF_MAXSWAP=4096/g' /etc/dphys-swapfile
        echo "swap大小已改為4096MB。請重啟您的機器以應用此更改。"
        exit 0
    fi
else
    if grep -q "CONF_MAXSWAP=4096" /etc/dphys-swapfile; then
        echo "swap大小已設定為4096MB，將繼續進行安裝程序"
    fi
fi

echo "正在安裝OpenCV 4.7.0"
echo "預估時間約3hr！"
cd ~

# 安裝依賴項
sudo apt-get install -y build-essential cmake git unzip pkg-config
sudo apt-get install -y libjpeg-dev libtiff-dev libpng-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y libgtk2.0-dev libcanberra-gtk* libgtk-3-dev
sudo apt-get install -y libgstreamer1.0-dev gstreamer1.0-gtk3
sudo apt-get install -y libgstreamer-plugins-base1.0-dev gstreamer1.0-gl
sudo apt-get install -y libxvidcore-dev libx264-dev
sudo apt-get install -y python3-dev python3-numpy python3-pip
sudo apt-get install -y libtbb2 libtbb-dev libdc1394-22-dev
sudo apt-get install -y libv4l-dev v4l-utils
sudo apt-get install -y libopenblas-dev libatlas-base-dev libblas-dev
sudo apt-get install -y liblapack-dev gfortran libhdf5-dev
sudo apt-get install -y libprotobuf-dev libgoogle-glog-dev libgflags-dev
sudo apt-get install -y protobuf-compiler

# 下載4.7.0
cd ~ 
sudo rm -rf opencv*
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.7.0.zip 
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.7.0.zip 
# 解壓縮
unzip opencv.zip 
unzip opencv_contrib.zip 
# 為了稍後方便，進行一些管理
mv opencv-4.7.0 opencv
mv opencv_contrib-4.7.0 opencv_contrib
# 清除zip檔案
rm opencv.zip
rm opencv_contrib.zip

# 設定安裝目錄
cd ~/opencv
mkdir build
cd build

# 執行cmake
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D ENABLE_NEON=ON \
-D WITH_OPENMP=ON \
-D WITH_OPENCL=OFF \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D WITH_GSTREAMER=ON \
-D BUILD_TESTS=OFF \
-D WITH_EIGEN=OFF \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D WITH_VTK=OFF \
-D WITH_QT=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_EXAMPLES=OFF ..

# 執行make 樹梅派4B有4核心，所以使用-j4
make -j4
sudo make install
sudo ldconfig

# 清理
make clean
sudo apt-get update

echo "完成"
