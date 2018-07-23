#!/bin/bash

set -e
set -o pipefail

DOTFILES="bash git vim gnupg config"
BINDIR="$HOME/bin"

install_brew_tools() {
    (
        cd homebrew &&
        brew bundle --verbose &&
        brew cleanup
    )
}

install_dotfiles() {
    echo "+ Installing dotfiles"

    for dir in $DOTFILES; do
        for file in "$dir"/* ; do
            target="$HOME/.$(basename $file)"
            cp -av "$file" "$target"
        done
    done
}

install_vim_plugins() {
    echo "+ Installing Vim plugins"

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    vim +PlugInstall
}

install_tools() {
    echo "+ Installing tools to $BINDIR"
    mkdir -p "$BINDIR"
    cp -av bin/* "$BINDIR"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    install_brew_tools
fi

install_dotfiles
install_tools
#install_vim_plugins

:
