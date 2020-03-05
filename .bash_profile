. ~/.profile
. ~/.profile-secret

if [ $(tty) = "/dev/tty1" ]; then
  exec sway 2>~/.sway.log
fi

. ~/.bashrc
