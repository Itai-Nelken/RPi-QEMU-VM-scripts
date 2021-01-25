#!/bin/bash

#############################################################################
#script by Itai Nelken - https://github.com/Itai-Nelken                     #
#---------------------------------------------------------------------------#
#the files this script uses: https://archive.org/details/macos_921_qemu_rpi #
#############################################################################

#clear the screen
clear

echo "this script will remove qemu 5.2 and MacOS 9.2 VM for you."
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

aria2="`cat ~/macos921/aria2-installed`"

if [[ "$aria2" == installed ]]; then
    aria2remove=1
fi

if [[ "$aria2remove" == 1 ]];then 
    echo -e "$(tput setaf 6)aria2 was installed by the VM install script$(tput sgr 0)"
    read -p "do you want to remove it (y/n)?" choice
    case "$choice" in 
        y|Y ) sudo apt purge aria2 ;;
        n|N ) echo "won't remove aria2" ;;
        * ) echo "invalid" ;;
    esac
fi

read -p "do you want to remove QEMU (y/n)?" choice
case "$choice" in 
    y|Y ) sudo apt purge qemu ;;
    n|N ) echo "won't remove qemu" ;;
    * ) echo "invalid" ;;
esac

echo -e "$(tput setaf 3)removing the files...$(tput sgr 0)"
rm -r ~/macos921
rm ~/Desktop/macos9.desktop

echo -e "$(tput setaf 3)$(tput bold)DONE!$(tput sgr 0)"
echo "exiting in 10 seconds"
sleep 10
rm remove-qemu-macos9.sh
