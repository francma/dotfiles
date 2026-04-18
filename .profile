export PATH=${HOME}/.local/bin:${PATH}

export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_STATE_HOME=${HOME}/.local/state
export XDG_CACHE_HOME=${HOME}/.cache

export EDITOR=nvim
export MANPAGER="nvim +Man!"

export TIME_STYLE=long-iso
export LC_CTYPE=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export DOCKER_HOME=${XDG_CONFIG_HOME}/docker
export CARGO_HOME=${XDG_DATA_HOME}/cargo
export INPUTRC=${XDG_CONFIG_HOME}/readline/inputrc
export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc
export LESSHISTFILE=${XDG_CACHE_HOME}/less/history
export JUPYTER_CONFIG_DIR=${XDG_CONFIG_HOME}/jupyter
export IPYTHONDIR=${XDG_CONFIG_HOME}/ipython
export PASSWORD_STORE_DIR=${XDG_DATA_HOME}/pass
export GOPATH="$XDG_DATA_HOME"/go
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
