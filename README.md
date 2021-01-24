# QEMU-VM-scripts

## All scripts:

### MacOS 9.2.1
**NOTES:**<br>don't use this VM if you have less than 2gb of RAM, to run it with less RAM, edit the desktop shortcut command from `-m 1000` to `-m <amont of ram in mb>`

 **Website:** [my archive.org page for it](https://archive.org/details/macos_921_qemu_rpi)<br>
  
**How to install:** simply run the following in terminal:
```bash
wget -qO- https://raw.githubusercontent.com/Itai-Nelken/RPi-QEMU-VM-scripts/main/MacOS9.2/qemu-macos9.sh | bash
```

**How to run:** from the Desktop shortcut or follow the instructions bellow:
  1) type the following in terminal to change to the VM folder (directory):
  ```bash
  cd ~/macos921
  ```
  2) type the following in terminal to start the VM:
  ```bash
  qemu-system-ppc -M mac99 -m 1000 -cpu "g4" -L pc-bios -g 1024x768x32 -hda macos921.qcow2
  ```

<!--
anything inside here isn't visible.
put your script in here under the category using the following template:

### OS name
**Website:** (if applicable)<br>
  
**How to install:**<br>
  
**How to run:**<br>
-->
