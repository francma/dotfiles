. ~/.profile
. ~/.profile-secret

if [ $(tty) = "/dev/tty1" ]; then
  sway
  exit 0
fi

. ~/.bashrc