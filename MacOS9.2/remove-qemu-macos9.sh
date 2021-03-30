#!/bin/bash

#############################################################################
#script by Itai Nelken - https://github.com/Itai-Nelken                     #
#---------------------------------------------------------------------------#
#the files this script uses: https://archive.org/details/macos_921_qemu_rpi #
#############################################################################

#clear the screen
clear -x

echo "this script will remove qemu 5.2 and MacOS 9.2 VM for you."
while true; do
  read -p "Do you want to proceed (y/n)?" choice
  if [[ "$choice" =~ [yY] ]]; then
    echo -e "$(tput setaf 2)$(tput bold)LOADING...$(tput sgr 0)"
    break
  elif [[ "$choice" =~ [nN] ]]; then
    echo "exiting..."
    sleep 1
    exit 0
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

aria2="$(cat ~/macos921/aria2-installed)"
qemu="$(cat ~/macos921/qemu-installed)"

if [[ "$aria2" == installed ]]; then
    aria2remove=1
elif [[ "$qemu" == installed ]]; then
    qemuremove=1
fi

if [[ "$aria2remove" == 1 ]];then 
    echo -e "$(tput setaf 6)aria2 was installed by the VM install script$(tput sgr 0)"
    while true; do
      read -p "do you want to remove it (y/n)?" choice
      if [[ "$choice" =~ [yY] ]]; then
        sudo apt purge -y aria2
        break
      elif [[ "$choice" =~ [nN] ]]; then
        echo "won't remove aria2c"
        break
      fi
    done
elif [[ "$qemuremove" == 1 ]]; then
    echo -e "$(tput setaf 6)QEMU was installed by the VM install script$(tput sgr 0)"
        while true; do
      read -p "do you want to remove it (y/n)?" choice
      if [[ "$choice" =~ [yY] ]]; then
        sudo apt purge -y qemu
        break
      elif [[ "$choice" =~ [nN] ]]; then
        echo "won't remove QEMU"
        break
      fi
    done    
fi

echo -e "$(tput setaf 3)removing the files...$(tput sgr 0)"
rm -r ~/macos921
rm ~/Desktop/macos9.desktop

echo -e "$(tput setaf 3)$(tput bold)DONE!$(tput sgr 0)"
rm remove-qemu-macos9.sh
