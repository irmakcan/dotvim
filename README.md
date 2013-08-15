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



Plugins:
--------
1. **ctrlp**: Fuzzy file finder.
2. **nerdtree**: Tree explorer.
3. **vim-snipmate**: TextMate style snippets.
4. **vim-snippets**: Snippets for snipmate.
5. **vim-colors-solarized**: Solarized colorscheme for vim.
6. **vim-railscasts-theme**: A beautiful theme for ruby development.
7. **tlib_vim**: Some utility functions for other plugins.
8. **vim-addon-mw-utils**: Some utility functions for other plugins.
