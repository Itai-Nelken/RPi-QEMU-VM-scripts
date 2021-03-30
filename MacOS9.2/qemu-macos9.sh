#!/bin/bash

#############################################################################
#script by Itai Nelken - https://github.com/Itai-Nelken                     #
#---------------------------------------------------------------------------#
#the files this script uses: https://archive.org/details/macos_921_qemu_rpi #
#############################################################################

#clear the screen by scrolling up (equivalent of [CTRL+L])
clear -x

echo "this script will install qemu 5.2 and create a MacOS 9.2 VM for you."
while true; do
  read -p "Do you want to proceed (y/n)?" choice
  if [[ "$choice" =~ [yY] ]]; then
    echo -e "$(tput setaf 2)$(tput bold)LOADING...$(tput sgr 0)"
    break
  elif [[ "$choice" =~ [nN] ]]; then
    echo "exiting..."; sleep 1; exit 0
  else
    echo "invalid option '$choice', please try again."
  fi
done

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


#determine if host system is 64 bit arm64 or 32 bit armhf
ARCH="$(uname -m)"
if [[ "$ARCH" == "x86_64" ]] || [[ "$ARCH" == "amd64" ]] || [[ "$ARCH" == "x86" ]] || [[ "$ARCH" == "i386" ]]; then
    echo "ERROR: '$ARCH' is a unsupported arch!"
    exit 1
elif [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]] || [[ "$ARCH" == "armv7l" ]] || [[ "$ARCH" == "armhf" ]]; then
    if [ ! -z "$(file "$(readlink -f "/sbin/init")" | grep 64)" ];then
        echo "OS is 64bit..."
        ARCH="64"
    elif [ ! -z "$(file "$(readlink -f "/sbin/init")" | grep 32)" ];then
        echo "OS is 32bit..."
        ARCH="32"
    else
        echo -e "$(tput setaf 1)$(tput bold)Can't detect OS architecture! something is very wrong!$(tput sgr 0)"
        exit 1
    fi
else
    echo -e "$(tput setaf 1)$(tput bold)ERROR: '$ARCH' isn't a supported architecture!$(tput sgr 0)"
    exit 1
fi

#variables
#DISKSIZE=2


#enter home folder
cd $HOME
sleep 0.3
clear -x

#install dependencies
echo -e "$(tput setaf 3)Installing dependencies...$(tput sgr 0)"
if ! which aria2c > /dev/null; then
   sudo apt install -y aria2
   clear
   aria2=1
else
    echo "dependencies already installed..."
fi


while true; do
  read -p "QEMU 5.2.90 will now be installed, do you want to continue (answering yes is recommended) (y/n)?" choice
  if [[ "$choice" =~ [yY] ]]; then
    CONTINUE=1
    break
  elif [[ "$choice" =~ [nN] ]]; then
    CONTINUE=0
    break
  else
    echo "invalid answer '$choice', please try again."
  fi
done

#install qemu
if [[ "$CONTINUE" == 1 ]]; then
    echo -e "$(tput setaf 3)Downloading qemu...$(tput sgr 0)"
    if [[ "$ARCH" == 32 ]]; then
      aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/qemu-5.2.90-armhf.deb
      echo -e "$(tput setaf 3)Installing qemu...$(tput sgr 0)"
      sudo apt install -fy ./qemu-5.2.90-armhf.deb
      QEMU=1
    elif [[ "$ARCH" == 64 ]]; then 
      aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/qemu_5.2.50-1_arm64.deb
      echo -e "$(tput setaf 3)Installing qemu...$(tput sgr 0)"
      sudo apt install -fy ./qemu_5.2.50-1_arm64.deb
      QEMU=1
    fi
else
  if ! which qemu-system-ppc &>/dev/null; then
    echo -e "$(tput setaf 1)$(tput bold)QEMU (specifically 'qemu-system-ppc') isn't installed! can't continue!$(tput sgr 0)"
    exit 1
  fi
  echo -e "$(tput setaf 1)QEMU won't be installed, but beware!\nif its installed from 'apt' the VM's will malfunction!$(tput sgr 0)"
  QEMU=0
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
Exec=qemu-system-ppc -M mac99 -m 1000 -cpu g4 -name \"MacOS 9.2.1\" -L pc-bios -g 1024x768x32 -hda macos921.qcow2
Icon=$HOME/macos921/macos9.png
Path=$HOME/macos921
Terminal=false
StartupNotify=true" > ~/Desktop/macos9.desktop
sudo chmod +x ~/Desktop/macos9.desktop

if [[ "$aria2" == 1 ]]; then
  echo "installed" > ~/macos921/aria2-installed
elif [[ "$QEMU" == 1 ]]; then
  echo "installed" > ~/macos921/qemu-installed
fi

echo -e "$(tput setaf 3)removing uneeded files...$(tput sgr 0)"
rm -f ~/macos921.tar.xz
rm -f ~/qemu-5.2.90-armhf.deb
echo -e "$(tput setaf 3)$(tput bold)DONE!$(tput sgr 0)"
rm -f qemu-macos9.sh &>/dev/null
