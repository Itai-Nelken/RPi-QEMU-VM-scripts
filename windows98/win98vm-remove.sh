#!/bin/bash

#############################################################################
#script by Itai Nelken - https://github.com/Itai-Nelken                     #
#---------------------------------------------------------------------------#
#############################################################################

#clear the screen
clear -x

echo "this script will remove qemu 5.2 and Windows 98 VM for you."
while true; do
  read -p "Do you want to proceed (y/n)?" choice
  if [[ "$choice" =~ [yY] ]]; then
    echo -e "$(tput setaf 2)$(tput bold)LOADING...$(tput sgr 0)"
    break
  elif [[ "$choice" =~ [nN] ]]; then
    echo "exiting..."
    sleep 1
    exit 0
  else
    echo "'$choice' is a invalid option! please try again."
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

#clear the screen again
clear -x

#enter home folder
cd $HOME

#variables
cowsay="$(cat ~/win98/cowsay-installed &>/dev/null)"
figlet="$(cat ~/win98/figlet-installed &>/dev/null)"
lolcat="$(cat ~/win98/lolcat-installed &>/dev/null)"
aria2="$(cat ~/win98/aria2-installed &>/dev/null)"
qemu="$(cat ~/win98/qemu-installed &>/dev/null)"

if [[ "$cowsay" == installed ]]; then
    cowsayremove=1
elif [[ "$figlet" == installed ]]; then
    figletremove=1
elif [[ "$lolcat" == installed ]]; then
    lolcatremove=1
elif [[ "$aria2" == installed ]]; then
    aria2remove=1
elif [[ "$qemu" == installed ]]; then
    qemuremove=1
fi

if [[ "$cowsayremove" == 1 ]];then 
    echo -e "$(tput setaf 6)cowsay was installed by the VM install script$(tput sgr 0)"
    while true; do
      read -p "do you want to remove it (y/n)?" choice
      if [[ "$choice" =~ [yY] ]]; then
        sudo apt purge cowsay -y
        break
      elif [[ "$choice" =~ [nN] ]]; then
        echo "won't remove cowsay"
        break
      else
        echo "'$choice' is a invalid option! please try again."
      fi
    done
    sleep 2
    clear -x
fi
if [[ "$figletremove" == 1 ]];then 
    echo -e "$(tput setaf 6)figlet was installed by the VM install script$(tput sgr 0)"
    while true; do
      read -p "do you want to remove it (y/n)?" choice
      if [[ "$choice" =~ [yY] ]]; then
        sudo apt purge figlet -y
        break
      elif [[ "$choice" =~ [nN] ]]; then
        echo "won't remove figlet"
        break
      else
        echo "'$choice' is a invalid option! please try again."
      fi
    done
    sleep 2
    clear -x
fi
if [[ "$lolcatremove" == 1 ]];then 
    echo -e "$(tput setaf 6)lolcat was installed by the VM install script$(tput sgr 0)"
     while true; do
      read -p "do you want to remove it (y/n)?" choice
      if [[ "$choice" =~ [yY] ]]; then
        sudo apt purge lolcat -y
        break
      elif [[ "$choice" =~ [nN] ]]; then
        echo "won't remove lolcat"
        break
      else
        echo "'$choice' is a invalid option! please try again."
      fi
    done
fi
if [[ "$aria2remove" == 1 ]];then 
    echo -e "$(tput setaf 6)aria2 was installed by the VM install script$(tput sgr 0)"
    while true; do
      read -p "do you want to remove it (y/n)?" choice
      if [[ "$choice" =~ [yY] ]]; then
        sudo apt purge aria2 -y
        break
      elif [[ "$choice" =~ [nN] ]]; then
        echo "won't remove aria2"
        break
      else
        echo "'$choice' is a invalid option! please try again."
      fi
    done
    sleep 2
    clear -x
fi
if [[ "$qemuremove" == 1 ]]; then
    echo -e "$(tput setaf 6)QEMU was installed by the VM install script$(tput sgr 0)"
     while true; do
      read -p "do you want to remove it (y/n)?" choice
      if [[ "$choice" =~ [yY]; then
        sudo apt purge qemu -y
        break
      elif [[ "$choice" =~ [nN] ]]; then
        echo "won't remove qemu"
        break
      else
        echo "'$choice' is a invalid option! please try again."
      fi
    done
    sleep 2
    clear -x
fi
echo -e "$(tput setaf 3)removing the files...$(tput sgr 0)"
rm -r ~/win98
rm ~/Desktop/win98.desktop

echo -e "$(tput setaf 3)$(tput bold)DONE!$(tput sgr 0)"
rm win98vm-remove.sh &>/dev/null
