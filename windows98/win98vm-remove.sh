#!/bin/bash

#############################################################################
#script by Itai Nelken - https://github.com/Itai-Nelken                     #
#---------------------------------------------------------------------------#
#the files this script uses: https://archive.org/details/macos_921_qemu_rpi #
#############################################################################

#clear the screen
clear

echo "this script will remove qemu 5.2 and Windows 98 VM for you."
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

#clear the screen again
clear

#enter home folder
cd $HOME

#variables
cowsay="`cat ~/win98/cowsay-installed`"
figlet="`cat ~/win98/figlet-installed`"
lolcat="`cat ~/win98/lolcat-installed`"
aria2="`cat ~/win98/aria2-installed`"

if [[ "$cowsay" == installed ]]; then
    cowsayremove=1
elif [[ "$figlet" == installed ]]; then
    figletremove=1
elif [[ "$lolcat" == installed ]]; then
    lolcatremove=1
elif [[ "$aria2" == installed ]]; then
    aria2remove=1
fi

if [[ "$cowsayremove" == 1 ]];then 
    echo -e "$(tput setaf 6)cowsay was installed by the VM install script$(tput sgr 0)"
    read -p "do you want to remove it (y/n)?" choice
    case "$choice" in 
        y|Y ) sudo apt purge cowsay -y ;;
        n|N ) echo "won't remove cowsay" ;;
        * ) echo "invalid" ;;
    esac
    sleep 2
    clear
elif [[ "$figletremove" == 1 ]];then 
    echo -e "$(tput setaf 6)figlet was installed by the VM install script$(tput sgr 0)"
    read -p "do you want to remove it (y/n)?" choice
    case "$choice" in 
        y|Y ) sudo apt purge figlet -y ;;
        n|N ) echo "won't remove figlet" ;;
        * ) echo "invalid" ;;
    esac
    sleep 2
    clear
elif [[ "$lolcatremove" == 1 ]];then 
    echo -e "$(tput setaf 6)lolcat was installed by the VM install script$(tput sgr 0)"
    read -p "do you want to remove it (y/n)?" choice
    case "$choice" in 
        y|Y ) sudo apt purge lolcat -y ;;
        n|N ) echo "won't remove lolcat" ;;
        * ) echo "invalid" ;;
    esac
    sleep 2
    clear
elif [[ "$aria2remove" == 1 ]];then 
    echo -e "$(tput setaf 6)aria2 was installed by the VM install script$(tput sgr 0)"
    read -p "do you want to remove it (y/n)?" choice
    case "$choice" in 
        y|Y ) sudo apt purge aria2 -y ;;
        n|N ) echo "won't remove aria2" ;;
        * ) echo "invalid" ;;
    esac
    sleep 2
    clear
fi

read -p "do you want to remove QEMU (y/n)?" choice
case "$choice" in 
    y|Y ) sudo apt purge qemu -y ;;
    n|N ) echo "won't remove qemu" ;;
    * ) echo "invalid" ;;
esac

echo -e "$(tput setaf 3)removing the files...$(tput sgr 0)"
rm -r ~/win98
rm ~/Desktop/win98.desktop

echo -e "$(tput setaf 3)$(tput bold)DONE!$(tput sgr 0)"
echo "exiting in 10 seconds"
sleep 10
exit
