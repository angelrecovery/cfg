# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository using GNU Stow for symlink management. The repository manages configuration files for a development environment primarily used on macOS.

## Architecture

- `scripts/bootstrap.sh` - Sets up the entire development environment from scratch, installing Homebrew, oh-my-zsh, zsh plugins, and development tools
- `scripts/stow.sh` - Uses GNU Stow to symlink all dotfiles from `stowed/` to `$HOME`
- `stowed/` - Contains all dotfiles and configuration directories that will be symlinked to the home directory

## Key Commands

### Initial Setup
```bash
# Bootstrap entire environment (run once on new machine)
./scripts/bootstrap.sh

# Symlink all dotfiles to home directory
./scripts/stow.sh
# or manually:
stow --target="$HOME" stowed
```

### Managing Dotfiles
```bash
# Add new dotfiles by placing them in stowed/ directory
# Then re-run stow to create symlinks
stow --target="$HOME" stowed

# Remove symlinks
stow --target="$HOME" --delete stowed
```

## Development Environment

The bootstrap script installs a comprehensive development toolchain including:
- Terminal: ghostty, zsh with oh-my-zsh
- Editors: neovim
- Development tools: git, gh, rustup, node, go, zig, llvm
- CLI utilities: ripgrep, fd, fzf, lazygit, lazydocker, bat, lsd, zoxide, atuin

Configuration files are managed for:
- Neovim (Lua-based config)
- Git settings
- Zsh shell
- Various CLI tools (lazygit, htop, btop, etc.)
