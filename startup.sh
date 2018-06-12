#!/bin/bash

# Startup script for Ubuntu-based machines.
# Installs a few essential machine learning libraries, as well as a simple desktop environment & VNC server for remote access.
# Use "-gpu" to check for and install NVIDIA CUDA drivers.

sudo apt-get update

echo "Checking for xfce4 desktop environment and installing."
  if ! dpkg-query -W xfce4; then
    sudo apt-get install dbus # necessary for successful install of xfce4, otherwise xfce4 installation will hang.
    sudo apt-get install xfce4
  fi

echo "Checking for vnc4server and installing."
  if ! dpkg-query -W vnc4server; then
    sudo apt-get install vnc4server
  fi
  
echo "Checking for git & installing."
if ! dpkg-query -W git; then
  sudo apt-get install git
fi

echo "Checking for numpy, scipy, and matplotlib, and installing."
  if ! dpkg-query -W python3-numpy; then
    sudo apt-get install python3-numpy
  fi

  if ! dpkg-query -W python3-scipy; then
    sudo apt-get install python3-scipy
  fi

  if ! dpkg-query -W python3-matplotlib; then
    sudo apt-get install python3-matplotlib
  fi

echo "Checking for R & RStudio and installing."
  if ! dpkg-query -W r-base; then
    sudo apt-get install r-base
  fi

  if ! dpkg-query -W rstudio; then
    sudo apt-get install libxslt1-dev # dependency of rstudio
    curl -O https://download1.rstudio.org/rstudio-xenial-1.1.453-amd64.deb
    sudo dpkg -i rstudio-xenial-1.1.453-amd64.deb
    rm rstudio-xenial-1.1.453-amd64.deb
  fi

echo "Checking for Visual Studio Code & installing."
  if ! dpkg-query -W code; then
    curl -O https://az764295.vo.msecnd.net/stable/6a6e02cef0f2122ee1469765b704faf5d0e0d859/code_1.24.0-1528306776_amd64.deb
    sudo dpkg -i code_1.24.0-1528306776_amd64.deb
    rm code_1.24.0-1528306776_amd64.deb
  fi
  

  if [ "$1" == "-gpu" ]; then
    echo "Checking for NVIDIA CUDA drivers & installing."
    if ! dpkg-query -W cuda-9-0; then
      curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
      sudo dpkg -i cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
      sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/7fa2af80.pub
      sudo apt-get update
      sudo apt-get install cuda-9-0
      rm cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
    fi
    # Enable persistence mode
    nvidia-smi -pm 1
  fi
  
  # start VNC server on port 5901. This will prompt for a password if it's being called for the first time.
  # TODO: add logic to only run this command if the server isn't already listening to port 5901.
  vncserver -localhost no -geometry 1024x768
