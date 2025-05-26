#!/usr/bin/env sh

set -xe

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install regular software
brew install \
    ghostty \
    neovim \
    zoxide \
    atuin \
    ripgrep \
    fd \
    zig \
    rustup \
    clang \
    node \
    fzf \
    lazygit \
    docker \
    bat \
    lsd \
    tokei \
    speedtest-cli \
    starship \
    htop \
    fastfetch \
