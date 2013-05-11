#! /bin/sh

mkdir tmp/

if [[ -L ~/.vimrc ]]; then
    rm ~/.vimrc
else
    mv ~/.vimrc tmp/vimrc
fi

if [[ -L ~/.gvimrc ]]; then
    rm ~/.gvimrc
else
    mv ~/.gvimrc tmp/gvimrc
fi
echo "Backedup existing vimrcs into tmp/"

ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/gvimrc ~/.gvimrc
echo "linked vimrcs"
