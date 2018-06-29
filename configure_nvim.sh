#! /bin/sh

mkdir -p "$HOME/.config/nvim"

if [[ -f "$HOME/.config/nvim/init.vim" ]]; then
  echo 'File exists at ~/.config/nvim/init.vim'
  echo 'Please backup or remove the file before continuing'
  exit 1
fi

cp -v "$HOME/.vim/nvim/init.vim" "$HOME/.config/nvim/"

