#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f $userresources ]; then
    xrdb -merge $userresources
fi

if [ -f $usermodmap ]; then
    xmodmap $usermodmap
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x $f ] && . $f
 done
 unset f
fi

setwallpaper &
# 'use localectl list-x11-keymap-options | grep grp' to get toggleing options
setxkbmap -layout us,hu -option 'grp:win_space_toggle' -option 'caps:swapescape'
unclutter --timeout 15 --ignore-scrolling --jitter 50 &
picom &
numlockx &
lxpolkit &
inactivity &
dwmblocks &
exec dwm
