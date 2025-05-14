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
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# Source private stuff
source .keychain

# Theme for fzf - https://github.com/catppuccin/fzf/blob/main/themes/catppuccin-fzf-mocha.sh
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"

# Alternatives for coreutils stuff
alias ls="lsd"
alias cat="bat --style=plain --theme=base16 --color=always"

# Other aliases
alias ff="fastfetch"

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
