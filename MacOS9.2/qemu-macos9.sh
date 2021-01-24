#!/bin/bash

#############################################################################
#script by Itai Nelken - https://github.com/Itai-Nelken                     #
#---------------------------------------------------------------------------#
#the files this script uses: https://archive.org/details/macos_921_qemu_rpi #
#############################################################################

#clear the screen
clear

echo "this script will install qemu 5.2 and create a MacOS 9.2 VM for you."
read -p "Do you want to proceed (y/n)?" choice
case "$choice" in 
  y|Y ) echo -e "$(tput setaf 2)$(tput bold)LOADING...$(tput sgr 0)";;
  n|N ) echo "exiting..."; sleep 1; exit;;
  * ) echo "invalid";;
esac

#loading bar
echo '  '
echo -ne '(0%)[#                         ](100%)\r'
sleep 0.1
echo -ne '(0%)[###                       ](100%)\r'
sleep 0.1
echo -ne '(0%)[#####                     ](100%)\r'
sleep 0.1
echo -ne '(0%)[########                  ](100%)\r'
sleep 0.1
echo -ne '(0%)[##############            ](100%)\r'
sleep 0.1
echo -ne '(0%)[####################      ](100%)\r'
sleep 0.1
echo -ne '(0%)[##########################](100%)\r'
sleep 0.5
echo -ne '\n'

#variables
DIRECTORY="$HOME/Downloads"
#CORES="`nproc`"
DISKSIZE=2

#clear the screen again
clear

#enter home folder
cd $HOME

#install dependencies
echo -e "$(tput setaf 3)Installing dependencies...$(tput sgr 0)"
if ! which aria2c > /dev/null; then
   sudo apt install -y aria2
   clear
elif ! which openbios-ppc > /dev/null; then
  sudo apt install -y openbios-ppc
  clear
else
    echo "dependencies already installed..."
fi



read -p "QEMU 5.2 will now be installed, do you want to continue (answering yes is recommended) (y/n)?" choice
case "$choice" in 
  y|Y ) CONTINUE=1;;
  n|N ) CONTINUE=0;;
  * ) echo "invalid";;
esac

#install qemu
if [[ "$CONTINUE" == 1 ]]; then
    echo -e "$(tput setaf 3)Downloading qemu...$(tput sgr 0)"
    aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/qemu_5.2_armhf.deb
    echo -e "$(tput setaf 3)Installing qemu...$(tput sgr 0)"
    sudo apt install --fix-broken -y ./qemu_5.2_armhf.deb
else
    echo -e "$(tput setaf 1)QEMU won't be installed, but beware!\nif its installed from 'apt' or not installed, this script will fail!$(tput sgr 0)"
fi

#make VM
echo -e "$(tput setaf 3)Downloading VM files...$(tput sgr 0)"
aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/macos921.tar.xz
echo -e "$(tput setaf 3)Extracting VM files...$(tput sgr 0)"
tar xf macos921.tar.xz
echo -e "$(tput setaf 3)Downloading desktop shortcut icon...$(tput sgr 0)"
wget https://archive.org/download/macos_921_qemu_rpi/macos9.png -O ~/macos921/macos9.png

#make desktop shortcut
echo -e "$(tput setaf 3)Creating Desktop shortcut...$(tput sgr 0)"
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=MacOS 9.2.1 
Comment=macos 9.2.1 qemu VM
Exec=qemu-system-ppc -M mac99 -m 1000 -cpu "g4" -L pc-bios -g 1024x768x32 -hda macos921.qcow2
Icon=$HOME/macos921/macos9.png
Path=$HOME/macos921
Terminal=false
StartupNotify=true" > ~/Desktop/macos9.desktop
sudo chmod +x ~/Desktop/macos9.desktop
echo -e "$(tput setaf 3)removing uneeded files...$(tput sgr 0)"
rm ~/macos921.tar.xz
rm ~/qemu_5.2_armhf.deb
echo -e "$(tput setaf 3)$(tput bold)DONE!$(tput sgr 0)"
echo "exiting in 10 seconds"
sleep 10