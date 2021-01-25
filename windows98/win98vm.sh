# !/bin/bash

# make everything clean
clear

#enter home folder
cd $HOME

#determine if host system is 64 bit arm64 or 32 bit armhf
if [ ! -z "$(file "$(readlink -f "/sbin/init")" | grep 64)" ];then
  figlet "This script can't run because your OS is 64bit!"
  exit
elif [ ! -z "$(file "$(readlink -f "/sbin/init")" | grep 32)" ];then
  figlet "OS is 32bit..."
else
  figlet "Can't detect OS architecture! something is very wrong!"
  exit
fi


# ask for some cool things
read -p "To make install experience more fun we will install figlet, cowsay, lolcat... (y/n)?" choice
case "$choice" in 
  y|Y ) CONTINUE=1 ;;
  n|N ) CONTINUE=0 ;;
  * ) echo "that is a invalid option my friend";;
esac

#install qemu
if [[ "$CONTINUE" == 1 ]]; then
  echo -e "$(tput setaf 2)$(tput bold)installing them...$(tput sgr 0)"
elif [[ "$CONTINUE" == 0 ]]; then
  echo " exiting.."; sleep 1; exit
fi

if ! which cowsay > /dev/null; then
   sudo apt install cowsay -y
   cowsay=1
elif ! which figlet > /dev/null; then
  sudo apt install figlet -y
  figlet=1
elif ! which lolcat > /dev/null; then
  sudo apt install lolcat -y
  lolcat=1
elif ! which aria2c > /dev/null; then
   sudo apt install -y aria2
   aria2=1
else
    echo "fun dependencies are already installed..."
fi


# lets clear the screen again. should we?
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

# ah yes install qemu 
aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/qemu-5.2.50-armhf.deb
sudo apt install --fix-broken -y ./qemu-5.2.50-armhf.deb

# time to get the vm files now...
cowsay okay.. the Dependencies are now installed... Downloading VM files... | lolcat
cd $HOME
wget https://github.com/Itai-Nelken/RPi-QEMU-VM-scripts/raw/main/windows98/win98.tar.xz

# extraction of the file is needed
tar xf win98.tar.xz

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
fi

# isnt it goot to delete unnecessary files and free up some space?
cowsay I\'m clearing all unnecessary files | lolcat
rm ~/win98.tar.xz
rm ~/qemu-5.2.50-armhf.deb
sleep 3
clear
# we have done everything!!! cheers!!!
figlet Yay Everything is Complete! | lolcat
echo exiting in 10 seconds..
sleep 10
exit
