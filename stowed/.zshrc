export ZSH="$HOME/.oh-my-zsh"

export SRC="$HOME/src"

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export RUST_LOG=info

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='hx'
fi

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source .keys
source <(fzf --zsh) # fzf keybinds

# rebind fzf ctrl-t to ctrl-f
bindkey -r '^T'
bindkey '^F' fzf-file-widget

alias cat="bat --style=plain"

cd $HOME
