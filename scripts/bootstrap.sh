#!/usr/bin/env sh

set -xe

# Install homebrew
bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# TODO: Install zsh plugins
# ...

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
