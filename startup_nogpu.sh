#!/bin/bash

# Installs a simple desktop environment & VNC server for remote access, and a few machine learning libraries.
   
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

echo "Checking for R & RStudio and installing."
  if ! dpkg-query -W r-base; then
    sudo apt-get install r-base
  fi

  if ! dpkg-query -W rstudio; then
    sudo apt-get install libxslt1-dev # dependency of rstudio
    wget https://download1.rstudio.org/rstudio-xenial-1.1.453-amd64.deb
    sudo dpkg -i rstudio-xenial-1.1.453-amd64.deb
    rm rstudio-xenial-1.1.453-amd64.deb
  fi
  
  # start VNC server on port 5901. This will prompt for a password if it's being called for the first time.
  # TODO: add logic to only run this command if the server isn't already listening to port 5901.
  vncserver -localhost no -geometry 1024x768
