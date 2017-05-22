#!/bin/bash
Cur_Dir=$(pwd)

# echo copy fonts
cp -r $Cur_Dir/fonts/consola /usr/share/fonts
cd /usr/share/fonts/consola/
mkfontscale
mkfontdir
fc-cache
cd $Cur_Dir
# echo copy powerline-font
sh $Cur_Dir/fonts/powerline-font/INSTALL.sh
