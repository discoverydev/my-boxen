#!/bin/bash

# This script installs Vim pathogen, a convenient package manager for Vim. 
# Please see https://github.com/tpope/vim-pathogen for more information.

if [ ! -f $HOME/.vim/autoload/pathogen.vim ]; then
    echo "Installing Vim Pathogen..."
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
else
    echo "Pathogen already present, exiting without changes."
fi
