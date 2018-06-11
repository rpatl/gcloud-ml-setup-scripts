#!/bin/bash
   
sudo apt-get update

echo "Checking for xfce4 desktop environment and installing."
  if ! dpkg-query -W xfce4; then
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

  if ! dpkg-query -W libxslt1-dev; then
    sudo apt-get install libxslt1-dev
  fi

#wget https://download1.rstudio.org/rstudio-xenial-1.1.453-amd64.deb
#sudo dpkg -i rstudio-xenial-1.1.453-amd64.deb
#rm rstudio-xenial-1.1.453-amd64.deb
#vncserver -localhost no -geometry 1024x768
