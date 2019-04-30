. ~/.profile
. ~/.profile-secret

if [ $(tty) = "/dev/tty1" ]; then
  export _JAVA_AWT_WM_NONREPARENTING=1
  export _JAVA_OPTIONS='-Dsun.java2d.opengl=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
  export BROWSER=firefox-nightly
  exec sway
  exit 0
fi

. ~/.bashrc
