set nocompatible

" === junegunn/vim-plug === "
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'ujihisa/tabpagecolorscheme' " Vim colorscheme on each tabs
Plug 'chriskempson/base16-vim'
Plug 'zeis/vim-kolor'
Plug 'altercation/vim-colors-solarized'
"Plug 'jpo/vim-railscasts-theme'

" Helpers
Plug 'tpope/vim-eunuch'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'qpkorr/vim-renamer'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-easy-align'

Plug 'Shougo/echodoc.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'

" Plugins for C# development
Plug 'OmniSharp/omnisharp-vim'
Plug 'vim-syntastic/syntastic' " Investigate
Plug 'Valloric/YouCompleteMe' " Investigate

Plug 'jiangmiao/auto-pairs'

Plug 'elzr/vim-json', { 'for': ['json'] } "Json only plugin
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" Plugin 'irmakcan/vim-snippets' " Update the clone if necessary

call plug#end()

" === COLORSCHEME === "
if ($COLORTERM == 'truecolor' || has('gui_macvim') || has('gui_running'))
  set termguicolors

  "colorscheme base16-default-dark
  colorscheme kolor " 256 color
  set background=dark

  "autocmd FileType cs colorscheme base16-default-dark
else
  let base16colorspace=256  " Access colors present in 256 colorspace
  let g:solarized_termcolors=256
  colorscheme kolor " 256 color
  "colorscheme base16-default-light
endif


" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59


"syntax on
"filetype plugin indent on

" === DEFAULT OPTIONS === "
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set nowrap

set backspace=2
set backspace=indent,eol,start

" make searches case sensitive only if the contain upper-case chars
set ignorecase smartcase

set wildmode=longest,list,full
set wildmenu

set number

" set pastetoggle=<F2>

" create hidden buffers easily
set hidden

" Disable bell sound
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" === MAPPINGS === "

" Mappings/Normal
nmap <C-N><C-N> :set invnumber<CR>

" Easier split navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

" Indent all file without moving the cursor
nmap _= :call Irmak#Preserve("normal gg=G")<CR>
" Remove trailing whitespaces in file
nmap _$ :call Irmak#Preserve("%s/\\s\\+$//e")<CR>


" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Toggle NERDTree
nmap <silent> <C-D> :NERDTreeToggle<CR>

" Toggle
nmap <leader>t :TagbarToggle<CR>

" ARROW KEYS ARE UNACCEPTABLE
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> 10k
map <Down> 10j


" snipmate trigger
"imap <C-J> <Plug>snipMateNextOrTrigger
"smap <C-J> <Plug>snipMateNextOrTrigger

" Mappings/Visual
" Substitute selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Mappings/Leader
nmap <leader>r :call Irmak#RenameFile()<cr>
nmap <leader>rv :source $MYVIMRC<cr>


" === Commands === "

command! ConvertTurkishChars :call Irmak#SubstituteTurkishChars()
command! ReplaceTurkishChars :call Irmak#SubstituteTurkishChars()

command! FormatJSON :call Irmak#FormatJSON()
command! FormatXML :call Irmak#FormatXML()

















" Enable snipmate


" MULTiPURPOSE TAB KEY
" Indent if we are at the beginning of a line. Else, do completion.
"function! InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>





" Comment/Uncomment using K, Ctrl-K
noremap   <buffer> K      :s,^\(\s*\)[^# \t]\@=,\1#,e<CR>:nohls<CR>zvj
noremap   <buffer> <C-K>  :s,^\(\s*\)#\s\@!,\1,e<CR>:nohls<CR>zvj

map <F10> <ESC>:tabnew ~/.vimrc<CR>
map <F12> <ESC>:w<CR>:!irb -r %:p<CR>

"if has("gui_macvim")
"  " set macvim specific stuff
"  " colors was not loaded if defined in gvimrc
"  colorscheme railscasts
"elseif has("gui_running")
"  " gvim stuff
"  " make backspace work like most other apps
"  set backspace=2
"  set backspace=indent,eol,start
"else
"  " only terminal vim specific stuff
"  " check for 256 color supported terminal
"  if $COLORTERM == 'gnome-terminal' || $TERM == 'xterm-256color'
"    set t_Co=256
"    colorscheme railscasts
"  else
"    colorscheme default
"  endif
"endif



" === PLUGINS === "
" Renamer Plugin
let g:RenamerSupportColonWToRename = 1

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" json-vim
let g:vim_json_syntax_conceal = 0

" Open NERDTree if no files specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Omnisharp
"
" OmniSharp won't work without this setting
filetype plugin on

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
"let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
  autocmd!

  "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
  "autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

  " Synchronous build (blocks Vim)
  "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
  " Builds can also run asynchronously with vim-dispatch installed
  autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
  " automatic syntax check on events (TextChanged requires Vim 7.4)
  autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

  " Automatically add new cs files to the nearest project on save
  autocmd BufWritePost *.cs call OmniSharp#AddToProject()

  "show type information automatically when the cursor stops moving
  autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

  "The following commands are contextual, based on the current cursor position.

  autocmd FileType cs nnoremap <leader>od :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <leader>oi :OmniSharpFindImplementations<cr>
  autocmd FileType cs nnoremap <leader>ot :OmniSharpFindType<cr>
  autocmd FileType cs nnoremap <leader>oy :OmniSharpFindSymbol<cr>
  autocmd FileType cs nnoremap <leader>ou :OmniSharpFindUsages<cr>
  "finds members in the current buffer
  autocmd FileType cs nnoremap <leader>om :OmniSharpFindMembers<cr>
  " cursor can be anywhere on the line containing an issue
  autocmd FileType cs nnoremap <leader>ox  :OmniSharpFixIssue<cr>
  autocmd FileType cs nnoremap <leader>oz :OmniSharpFixUsings<cr>
  autocmd FileType cs nnoremap <leader>ol :OmniSharpTypeLookup<cr>
  autocmd FileType cs nnoremap <leader>oc :OmniSharpDocumentation<cr>
  "navigate up by method/property/field
  autocmd FileType cs nnoremap <leader>o<Up> :OmniSharpNavigateUp<cr>
  "navigate down by method/property/field
  autocmd FileType cs nnoremap <leader>o<Down> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>or :OmniSharpRename<cr>
" nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>oo :OmniSharpReloadSolution<cr>
nnoremap <leader>of :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
" nnoremap <leader>op :OmniSharpAddToProject<cr>

" Start the omnisharp server for the current solution
nnoremap <leader>os :OmniSharpStartServer<cr>
nnoremap <leader>op :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>oh :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" Enable snippet completion, requires completeopt-=preview
let g:OmniSharp_want_snippet=1
let g:Omnisharp_highlight_user_types=1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDAltDelims_c = 1
let g:NERDAltDelims_cs = 1
map <D-/> <Plug>NERDCommenterToggle
imap <D-/> <ESC><Plug>NERDCommenterToggle

" === AUTOCMD === "
" Automatically strip whitspaces on save
autocmd BufWritePre * :normal _$ " was *.py,*.js,*.rb,*.erb,*.cs

augroup vimrcEx
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to the last known cursor position.
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

augroup END

