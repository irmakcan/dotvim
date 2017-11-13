
if has("gui_macvim")
  " MacVim stuff
else
  " gvim stuff

  " copy/paste for gvim
  " nnoremap <S-Insert> "+P
  inoremap <S-Insert> <Esc>"+Pa
  " map ,p "+p
  map ,p o<S-Insert><Esc>
  map ,P O<S-Insert><Esc>
  map ,y "+y
endif
