#!/bin/zsh

# setup prezto if not installed
if [[ ! -d "$HOME/.zprezto" ]]
then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

if [[ ! -d "$HOME/.zprezto/contrib" ]]
then
  git clone --recurse-submodules https://github.com/belak/prezto-contrib "$HOME/.zprezto/contrib"
fi

if [[ "$SHELL" != $(which zsh) ]]
then
  chsh -s $(which zsh)
fi

# install vim-plug if not present
if [[ ! -e "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]
then
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
