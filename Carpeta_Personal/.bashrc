#! /bin/bash

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#
# Global settings
#

export BROWSER="firefox"
if command -v nvim > /dev/null 2>&1; then
  export EDITOR="nvim"
  export DIFFPROG="nvim -d"
elif command -v vim > /dev/null 2>&1; then
  export EDITOR="vim"
  export DIFFPROG="vimdiff"
fi
export VISUAL="${EDITOR}"

#
# Set environment variables for programming languages
#

# go
if command -v go > /dev/null 2>&1; then
  export GOPATH="${HOME}/.go"
  if ! [[ "${PATH}" =~ :?${GOPATH}:? ]]; then
    export PATH="${GOPATH}/bin:${PATH}"
  fi
fi

# ruby
if command -v ruby > /dev/null 2>&1; then
  GEM_HOME=$(gem env user_gemhome)
  export GEM_HOME
  if ! [[ "${PATH}" =~ :?${GEM_HOME}/bin:? ]]; then
    PATH="${GEM_HOME}/bin:${PATH}"
    export PATH
  fi
fi

# rust
if command -v cargo > /dev/null 2>&1; then
  if ! [[ "${PATH}" =~ :?${HOME}/.cargo/bin:? ]]; then
    export PATH="${HOME}/.cargo/bin:${PATH}"
  fi
fi

if command -v luarocks > /dev/null 2>&1; then
  if ! [[ "${PATH}" =~ :?${HOME}/.luarocks/bin:? ]]; then
    export PATH="${HOME}/.luarocks/bin:${PATH}"
  fi
fi

# npm
if command -v npm > /dev/null 2>&1; then
  export NPM_CONFIG_PREFIX="${HOME}/.npm"
  if ! [[ "${PATH}" =~ :?${HOME}/.npm/bin:? ]]; then
    export PATH="${HOME}/.npm/bin:${PATH}"
  fi
fi

# R
if command -v R Rscript > /dev/null 2>&1; then
  R_LIBS_USER="$(Rscript --version)"
  R_LIBS_USER="${R_LIBS_USER%% ([0-9\-]*)}"
  R_LIBS_USER="${HOME}/.R/${R_LIBS_USER##Rscript (R) version }"
  if [ -n "${R_LIBS_USER}" ]; then
    export R_LIBS_USER
    if ! [ -d "${R_LIBS_USER}" ]; then
      mkdir -p "${R_LIBS_USER}"
    fi
    alias R='R --no-save '
    if [ -d /usr/share/mathjax ]; then
      export RMARKDOWN_MATHJAX_PATH=/usr/share/mathjax
    fi
  fi
fi

# beet autocompletion
if command -v beet > /dev/null 2>&1; then
  if ! [ -f "/usr/share/bash-completion/completions/beet" ] &&
     ! [ -f "${HOME}/.local/share/bash-completion/completions/beet" ]; then
    eval "$(beet completion)"
  fi
fi

# custom scripts
if ! [[ "${PATH}" =~ :?${HOME}/.scripts:? ]]; then
  export PATH="${HOME}/.scripts:${PATH}"
fi

# local executables
if ! [[ "${PATH}" =~ :?${HOME}/.local/bin:? ]]; then
  export PATH="${HOME}/.local/bin:${PATH}"
fi

# local libraries
if ! [[ "${LD_LIBRARY_PATH}" =~ :?/usr/local/lib:? ]]; then
  LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"
fi
if ! [[ "${LD_LIBRARY_PATH}" =~ :?${HOME}/.local/lib:? ]]; then
  LD_LIBRARY_PATH="${HOME}/.local/lib:${LD_LIBRARY_PATH}"
fi
export LD_LIBRARY_PATH

#
# Set bash aliases
#

if command -v nvim > /dev/null 2>&1; then
  alias vi='nvim '
  alias vim='nvim '
  alias vimdiff='nvim -d '
elif command -v vim > /dev/null 2>&1; then
  alias vi='vim '
fi
alias sudo='sudo '
alias visudo='EDITOR=${EDITOR} visudo '
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias happymake='make -j$(nproc) && sudo make install'

function superupgrade {
  sudo sh -c 'pacman -Syu && paccache -r && paccache -ruk0'
}

function megapurge {
  sudo sh -c 'yes | pacman -Scc' &&
    sudo journalctl --rotate &&
    sudo journalctl --vacuum-time=1s &&
    pacdiff -s

  local pkg
  mapfile -t pkg < <(pacman -Qtdq)
  if [ "${#pkg}" -gt 0 ]; then
    sudo pacman -Rs --noconfirm "${pkg[@]}"
  fi
}

function make_silent {
  if command -v "${1}" > /dev/null 2>&1; then
    local cmd
    local bin
    bin="$(which "${1}")"
    cmd="function ${1} { local cmd=\"(${bin} \${@@Q} > /dev/null 2>&1 &)\"; eval \"\${cmd}\"; }"
    eval "${cmd}"
  fi
}

function run_silent {
  if command -v "${1}" > /dev/null 2>&1; then
    local bin="${1}"
    local args=("${@:2}")
    (${bin} "${args[@]}" > /dev/null 2>&1 &)
  fi
}

make_silent ebook-viewer
make_silent eog
make_silent evince
make_silent feh
make_silent firefox
make_silent gimp
make_silent gitg
make_silent gitk
make_silent gwenview
make_silent inkscape
make_silent krita
make_silent okular

unset -f make_silent

if { command -v yt-dlp && ! command -v youtube-dl; } > /dev/null 2>&1; then
  alias youtube-dl='yt-dlp '
fi

# list directory contents
alias ls='ls --color=auto'
alias sl='ls'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

#
# Color terminal output
#

# color ls output based on filetype
eval "$(dircolors -b)"

# color the man pages
if command -v nvim > /dev/null 2>&1; then
  export MANPAGER='nvim +Man! --clean'
else
  export MANPAGER="less -R --use-color -Dd+r -Du+b -s -M +Gg"
  # export MANROFFOPT="-P -c"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export WAYDROID_ACTIVE_DISPLAY=$(echo $DISPLAY)
