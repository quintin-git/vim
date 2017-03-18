# echo copy .
Cur_Dir=$(pwd)
cp -r $Cur_Dir/fonts/powerline-font/consolas-font-for-powerline ~/.fonts/
cd ~/.fonts/
mkfontscale
mkfontdir
fc-cache
cd $Cur_Dir
# echo copy end.
