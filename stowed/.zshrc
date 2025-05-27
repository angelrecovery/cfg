export ZSH="$HOME/.oh-my-zsh"

export XDG_CONFIG_HOME="$HOME/.config"

export SRC="$HOME/src"

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# rust `env_logger` crate
export RUST_LOG=info

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# Source private stuff
source $HOME/.keychain

# Theme for fzf (onedark)
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --pointer="❯"
  --color=fg:#abb2bf,bg:#282c34,hl:#61afef
  --color=fg+:#e5c07b,bg+:#3e4451,hl+:#528bff
  --color=info:#56b6c2,prompt:#c678dd,pointer:#98c379
  --color=marker:#e06c75,spinner:#61afef,header:#61afef'

# Aliases for coreutils alternatives
alias ls="lsd"
alias cat="bat --style=plain --theme=base16 --color=always"

# Miscellaneous aliases
alias g="git"
alias cl="clear"
alias ff="fastfetch"
alias tk="tokei"
alias speed="speedtest-cli"

# https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration
source <(fzf --zsh)
# https://github.com/starship/starship?tab=readme-ov-file#step-2-set-up-your-shell-to-use-starship
eval "$(starship init zsh)"
# https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
eval "$(zoxide init zsh)"
# https://docs.atuin.sh/guide/installation/#installing-the-shell-plugin
eval "$(atuin init zsh)"

# Accept autosuggestions with tab
bindkey '^I' autosuggest-accept 
# Rebind fzf `Ctrl-T` to `Ctrl-F`
bindkey -r '^T' && bindkey '^F' fzf-file-widget

cd $HOME
