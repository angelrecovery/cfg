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
