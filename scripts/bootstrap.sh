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
    docker \
    bat \
    lsd \
    tokei \
    speedtest-cli \
    starship \
    htop \
    fastfetch \
    tree-sitter \
echo "scripts/bootstrap: done!"
