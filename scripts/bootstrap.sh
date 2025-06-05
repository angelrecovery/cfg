#!/usr/bin/env sh

set -xe

# Install homebrew
bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install regular software
brew install \
    ghostty \
    gnupg \
    git \
    gh \ 
    wget \
    difftastic \
    neovim \
    zoxide \
    atuin \
    ripgrep \
    fd \
    llvm \
    zig \
    rustup \
    make \
    cmake \
    node \
    go \
    fzf \
    lazygit \
    lazydocker \
    docker \
    docker-compose \
    bat \
    lsd \
    tokei \
    man \
    tlrc \
    hexyl \
    monolith \
    speedtest-cli \
    starship \
    htop \
    fastfetch \
    tree-sitter \

echo "scripts/bootstrap: done!"
