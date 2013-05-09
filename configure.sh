#! /bin/sh

mkdir tmp/
mv ~/.vimrc tmp/vimrc
mv ~/.gvimrc tmp/gvimrc

ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/gvimrc ~/.gvimrc

git submodule foreach git pull origin master
