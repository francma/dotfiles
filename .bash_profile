. ~/.profile
. ~/.profile-secret

if [ $(tty) = "/dev/tty1" ]; then
  export _JAVA_AWT_WM_NONREPARENTING=1
  export _SILENT_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
  export BROWSER=firefox
  export LIBVA_DRIVER_NAME=iHD
  exec sway 2>~/.sway.log
  exit 0
fi

. ~/.bashrc
