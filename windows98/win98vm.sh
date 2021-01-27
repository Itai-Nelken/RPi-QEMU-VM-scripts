# !/bin/bash

# make everything clean
clear

#enter home folder
cd $HOME

# ask for some cool things
read -p "To make install experience more fun we will install figlet, cowsay, lolcat... (y/n)?" choice
case "$choice" in 
  y|Y ) CONTINUE=1 ;;
  n|N ) CONTINUE=0 ;;
  * ) echo "that is a invalid option my friend";;
esac
if [[ "$CONTINUE" == 1 ]]; then
  if ! which cowsay &>/dev/null; then
    sudo apt install cowsay -y
    cowsay=1
  else
    cowsay "cowsay already installed..."
  fi
  if ! which figlet &>/dev/null; then
   sudo apt install figlet -y
    figlet=1
  else
    figlet "figlet already installed..."
  fi
  if ! which lolcat &>/dev/null; then
    sudo apt install lolcat -y
    lolcat=1
  else
    lolcat already installed | lolcat
  fi
elif [[ "$CONTINUE" == 0 ]]; then
  echo "script can't run!"
  exit
fi

#determine if host system is 64 bit arm64 or 32 bit armhf
if [ ! -z "$(file "$(readlink -f "/sbin/init")" | grep 64)" ];then
  figlet "OS is 64bit..."
  ARCH=64
elif [ ! -z "$(file "$(readlink -f "/sbin/init")" | grep 32)" ];then
  figlet "OS is 32bit..."
  ARCH=32
else
  figlet "Can't detect OS architecture! something is very wrong!"
  exit
fi

sleep 3
clear

# there we start the installation
echo "this script will install and create a Windows 98 VM for you."
read -p "Do you want to proceed (y/n)?" choice
case "$choice" in 
  y|Y ) cowsay oke! lets start the install now | lolcat ;;
  n|N ) cowsay OK exiting.. | lolcat; sleep 1; exit ;;
  * ) cowsay that is a invalid option my friend | lolcat ;;
esac

cowsay ok im installing dependencies | lolcat

#install aria2c
if ! which aria2c &>/dev/null; then
  sudo apt install -y aria2
  aria2=1
else
  aria2c already installed...
fi

read -p "QEMU 5.2 will now be installed, do you want to continue (answering yes is recommended) (y/n)?" choice
case "$choice" in 
  y|Y ) CONTINUE1=1;;
  n|N ) CONTINUE1=0;;
  * ) echo "invalid";;
esac

#install qemu
if [[ "$CONTINUE1" == 1 ]]; then
    echo -e "$(tput setaf 3)Downloading qemu...$(tput sgr 0)"
    if [[ "$ARCH" == 32 ]]; then
      aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/qemu-5.2.50-armhf.deb
      echo -e "$(tput setaf 3)Installing qemu...$(tput sgr 0)"
      sudo apt install --fix-broken -y ./qemu-5.2.50-armhf.deb
      QEMU=1
    elif [[ "$ARCH" == 64 ]]; then 
      aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/qemu_5.2.50-1_arm64.deb
      echo -e "$(tput setaf 3)Installing qemu...$(tput sgr 0)"
      sudo apt install --fix-broken -y ./qemu_5.2.50-1_arm64.deb
      QEMU=1
    fi
else
  if ! which qemu-system-x86_64 &>/dev/null; then
    figlet "QEMU isn't installed! can't continue!"
    exit
  fi
  echo -e "$(tput setaf 1)QEMU won't be installed, but beware!\nif its installed from 'apt' the VM's will malfunction!$(tput sgr 0)"
  QEMU=0
fi
sleep 3
clear

# time to get the vm files now...
cowsay okay.. the Dependencies are now installed... Downloading VM files... | lolcat
cd $HOME
wget https://github.com/Itai-Nelken/RPi-QEMU-VM-scripts/raw/main/windows98/win98.tar.xz

# extraction of the file is needed
tar xf win98.tar.xz

echo " "
echo " "
echo " "
echo " "
# desktop shortcuts are handy.. isnt it?
cowsay Now i am Creating Desktop shortcut... | lolcat 
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Windows 98 
Comment=WIndows 98 qemu VM
Exec=qemu-system-x86_64 -hda win98.qcow2 -m 1000 -device sb16
Icon=$HOME/win98/win98.png
Path=$HOME/win98
Terminal=false
StartupNotify=true" > ~/Desktop/win98.desktop
sudo chmod +x ~/Desktop/win98.desktop

if [[ "$cowsay=1" == 1 ]]; then
  echo "installed" > ~/win98/cowsay-installed
elif [[ "$figlet" == 1 ]]; then
  echo "installed" > ~/win98/figlet-installed
elif [[ "$lolcat" == 1 ]]; then
  echo "installed" > ~/win98/lolcat-installed
elif [[ "$aria2" == 1 ]]; then
  echo "installed" > ~/win98/aria2-installed
elif [[ "$QEMU" == 1 ]]; then
  echo "installed" > ~/win98/qemu-installed
fi

# isnt it goot to delete unnecessary files and free up some space?
cowsay I\'m clearing all unnecessary files | lolcat
rm ~/win98.tar.xz
rm ~/qemu-5.2.50-armhf.deb
clear
sleep 3
# we have done everything!!! cheers!!!
figlet Yay Everything is Complete! | lolcat
rm win98vm.sh
