#!/bin/bash
Cur_Dir=$(pwd)

echo "Import vimrc"
cp -r etc/vimrc	/etc/vimrc
echo "Import vim plugin"
mv vim .vim
cp -r .vim ~/
mv .vim vim
echo "install fonts"
sh $Cur_Dir/fonts/INSTALL.sh
echo "Install successful"
