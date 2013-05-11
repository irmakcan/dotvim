dotvim
======


Installation:
-------------

Important: Backup your files ~/.vimrc, ~/.gvimrc and ~/.vim/ folder before starting to installation.

``` sh
git clone https://github.com/irmakcan/dotvim.git ~/.vim/
git submodule init
git submodule update
./configure.sh
```


Pulling changes:
----------------

``` sh
git pull
git submodule init
git submodule update
./configure.sh
```


Making changes on submodules:
-----------------------------

You should be able to push changes to the origin repo of that submodule in order to make your changes visible to everyone.
If you do not have access or cannot send pull reqests, fork the repo and configure the .gitmodules file in 'dotvim' to point your owning repo.
