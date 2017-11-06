execute pathogen#infect()
call pathogen#helptags()

syntax on
filetype plugin indent on

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
nmap <C-N><C-N> :set invnumber<CR>

set pastetoggle=<F2>

" create hidden buffers easily
set hidden

" snipmate trigger
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" Substitute selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" CUSTOM AUTOCOMMANDS "
augroup vimrcEx
  autocmd!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et
augroup END

imap <c-l> <space>=><space>

" Enable snipmate
:filetype plugin on
" Load html snippets on erb files
au BufNewFile,BufRead *.html.erb set filetype=xml.eruby.html

" Easier split navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

" MULTiPURPOSE TAB KEY
" Indent if we are at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" ARROW KEYS ARE UNACCEPTABLE
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> 10k
map <Down> 10j

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" PROMOTE VARIABLE TO RSPEC LET
function! PromoteToLet()
    :normal! dd
    " :exec '?^\s*it\>'
    :normal! P
    :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
    :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

" SWITCH BETWEEN TEST AND PRODUCTION CODE
function! OpenTestAlternate()
    let new_file = AlternateForCurrnetFile()
    exec ':e ' . new_file
endfunction
function! AlternateForCurrnetFile()
    let current_file = expand("%")
    let new_file = current_file
    let in_spec = match(current_file, '^spec/') != -1
    let going_to_spec = !in_spec
    let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file , '\<models\>') != -1 || match(current_file, '\<views\>') != -1
    if going_to_spec
        if in_app
            let new_file = substitute(new_file, '^app/', '', '')
        end
        let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
        let new_file = 'spec/' . new_file
    else
        let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
        let new_file = substitute(new_file, '^spec/', '', '')
        if in_app
            let new_file = 'app/' . new_file
        end
    endif
    return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!bundle exec rspec " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>r :call RunTestFile()<cr>
" " Run only the example under the cursor
map <leader>T :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>
" map <leader>a :call RunTests('spec')<cr>all pathogen#infect()

" Reloads the state after executing the command
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>
 
" Automatically strip whitspaces on save
autocmd BufWritePre *.py,*.js,*.rb,*.erb :normal _$
 
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
 
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Comment/Uncomment using K, Ctrl-K
noremap   <buffer> K      :s,^\(\s*\)[^# \t]\@=,\1#,e<CR>:nohls<CR>zvj
noremap   <buffer> <C-K>  :s,^\(\s*\)#\s\@!,\1,e<CR>:nohls<CR>zvj

map <F10> <ESC>:tabnew ~/.vimrc<CR>
map <F12> <ESC>:w<CR>:!irb -r %:p<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

autocmd BufNewFile,BufRead Gemfile,Guardfile,Rakefile,Podfile,Snapfile set filetype=ruby
autocmd BufNewFile,BufRead *.rabl,*.jbuilder set filetype=ruby

" Open NERDTree if no files specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Toggle NERDTree
nmap <silent> <C-D> :NERDTreeToggle<CR>

if has("gui_macvim")
  " set macvim specific stuff
  " colors was not loaded if defined in gvimrc
  colorscheme railscasts
elseif has("gui_running") 
  " gvim stuff
  " make backspace work like most other apps
  set backspace=2 
  set backspace=indent,eol,start
else
  " only terminal vim specific stuff
  " check for 256 color supported terminal
  if $COLORTERM == 'gnome-terminal' || $TERM == 'xterm-256color'
    set t_Co=256
    colorscheme railscasts 
  else
    colorscheme default 
  endif
endif

" Replace all characters
function! ReplaceAllCharsInFile(old_char, new_char)
  execute ":%s/" . a:old_char . "/" . a:new_char . "/ge"
endfunction

" Substitude Turkish chars
function! SubstituteTurkishChars()
  " Common chars
  call ReplaceAllCharsInFile("Ý", "İ")
  call ReplaceAllCharsInFile("ý", "ı")

  call ReplaceAllCharsInFile("Þ", "Ş")
  call ReplaceAllCharsInFile("þ", "ş")

  call ReplaceAllCharsInFile("Ð", "Ğ")
  call ReplaceAllCharsInFile("ð", "ğ")

  let filename=expand("%:t:r")
  let extension=expand("%:e")
  execute "w! ++enc=utf-8 " . filename . "." . extension
endfunction

:command ConvertTurkishChars :call SubstituteTurkishChars()
:command ReplaceTurkishChars :call SubstituteTurkishChars()


" Disable bell sound
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Format json file
function! FormatJSON()
  :%!python -m json.tool
endfunction

:command FormatJSON :call FormatJSON()

function! FormatXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! FormatXML call FormatXML()

" Renamer Plugin
let g:RenamerSupportColonWToRename = 1

