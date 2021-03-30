# !/bin/bash

# make everything clean
clear -x

#enter home folder
cd $HOME

# ask for some cool things
while true; do
  read -p "To make the install experience more fun we will install figlet, cowsay, lolcat... (y/n)?" choice
  if [[ "$choice" =~ [yY] ]]; then
    CONTINUE=1
    break
  elif [[ "$choice" =~ [nN] ]]; then
    CONTINUE=0
    break
  else
    echo "'$choice' is a invalid option my friend... please try again."
  fi
done

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
    echo "lolcat already installed" | lolcat
  fi
elif [[ "$CONTINUE" == 0 ]]; then
  echo "the script can't run without the dependencies!"
  exit 1
fi

#determine if host system is 64 bit arm64 or 32 bit armhf

#determine if host system is 64 bit arm64 or 32 bit armhf
ARCH="$(uname -m)"
if [[ "$ARCH" == "x86_64" ]] || [[ "$ARCH" == "amd64" ]] || [[ "$ARCH" == "x86" ]] || [[ "$ARCH" == "i386" ]]; then
    echo "ERROR: '$ARCH' is a unsupported arch!"
    exit 1
elif [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]] || [[ "$ARCH" == "armv7l" ]] || [[ "$ARCH" == "armhf" ]]; then
    if [ ! -z "$(file "$(readlink -f "/sbin/init")" | grep 64)" ];then
      figlet "OS is 64bit..."
      ARCH=64
    elif [ ! -z "$(file "$(readlink -f "/sbin/init")" | grep 32)" ];then
        figlet "OS is 32bit..."
        ARCH="32"
    else
        echo -e "$(tput setaf 1)$(tput bold)Can't detect OS architecture! something is very wrong!$(tput sgr 0)"
        exit 1
    fi
else
    echo -e "$(tput setaf 1)$(tput bold)ERROR: '$ARCH' isn't a supported architecture!$(tput sgr 0)"
    exit 1
fi

sleep 2
clear -x

# there we start the installation
echo "this script will install and create a Windows 98 VM for you."
while true; do
  read -p "Do you want to proceed (y/n)?" choice
  if [[ "$choice" =~ [yY] ]]; then
    cowsay "oke! lets start the install now" | lolcat
    break
  elif [[ "$choice" =~ [nN] ]]; then
    cowsay "OK exiting..." | lolcat
    sleep 1
    exit 0
  else 
    cowsay "'$choice' is a invalid option my friend | lolcat"
  fi
done
cowsay "ok im installing dependencies" | lolcat

#install aria2c
if ! which aria2c &>/dev/null; then
  sudo apt install -y aria2
  aria2=1
else
  figlet "aria2c already installed..."
fi

while true; do
  read -p "QEMU 5.2.50 will now be installed, do you want to continue (answering yes is recommended) (y/n)?" choice
  if [[ "$choice" =~ [yY] ]]; then
    CONTINUE=1
    break
  elif [[ "$choice" =~ [nN] ]]; then
    CONTINUE=0
    break
  else
    echo "'$choice' is a invalid option, please try again" | lolcat
  fi
done

#install qemu
if [[ "$CONTINUE1" == 1 ]]; then
    echo -e "$(tput setaf 3)Downloading qemu...$(tput sgr 0)"
    if [[ "$ARCH" == 32 ]]; then
      aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/qemu-5.2.90-armhf.deb
      echo -e "$(tput setaf 3)Installing qemu...$(tput sgr 0)"
      sudo apt install --fix-broken -y ./qemu-5.2.90-armhf.deb
      QEMU=1
    elif [[ "$ARCH" == 64 ]]; then 
      aria2c -x 16 https://archive.org/download/macos_921_qemu_rpi/qemu_5.2.50-1_arm64.deb
      echo -e "$(tput setaf 3)Installing qemu...$(tput sgr 0)"
      sudo apt install -fy ./qemu_5.2.50-1_arm64.deb
      QEMU=1
    fi
else
  if ! which qemu-system-x86_64 &>/dev/null; then
    figlet "QEMU (specifically 'qemu-system-x86_64') isn't installed! can't continue!"
    exit 1
  fi
  echo -e "$(tput setaf 1)QEMU won't be installed, but beware!\nif its installed from 'apt' the VM's will malfunction!$(tput sgr 0)"
  QEMU=0
fi
sleep 3
clear -x

# time to get the vm files now...
cowsay "okay.. the Dependencies are now installed... Downloading VM files..." | lolcat
cd $HOME
wget https://github.com/Itai-Nelken/RPi-QEMU-VM-scripts/raw/main/windows98/win98.tar.xz

# extraction of the file is needed
tar xf win98.tar.xz

echo " "
echo " "
echo " "
echo " "
# desktop shortcuts are handy.. isnt it?
cowsay "Now i am Creating Desktop shortcut..." | lolcat 
echo "[Desktop Entry]
Type=Application
Name=Windows 98 
Comment=WIndows 98 qemu VM
Exec=qemu-system-x86_64 -name "Windows 98" -hda win98.qcow2 -m 1000 -device sb16
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

# isnt it good to delete unnecessary files and free up some space?
cowsay I\'m clearing all unnecessary files | lolcat
rm -f ~/win98.tar.xz
rm -f ~/qemu-5.2.90-armhf.deb
clear -x
sleep 3
# we have done everything!!! cheers!!!
figlet "Yay Everything is Complete!" | lolcat
rm -f win98vm.sh &>/dev/null
