export PATH=$PATH:~/bin:~/.config/composer/vendor/bin:~/.local/bin:~/projects/carvago/backend-monorepo/bin
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export EDITOR=nvim
export TERMINAL=foot
export MANPAGER="nvim +Man!"

export TIME_STYLE=long
export LC_CTYPE=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export _JAVA_AWT_WM_NONREPARENTING=1
export _SILENT_JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

export TEAS_PHP_IDE_CONFIG="serverName=docker"
export TEAS_XDEBUG_CONFIG=""

export MOZ_ENABLE_WAYLAND=1
export MOZ_DISABLE_RDD_SANDBOX=1

export LIBSEAT_BACKEND=logind
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

