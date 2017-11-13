

" Reloads the state after executing the command
function! Irmak#Preserve(command)
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

function! Irmak#RenameFile() abort
  if !exists(':Rename')
    echoerr 'No :Rename command exists. Check plugins.'
    return
  endif
  let s:current_file_name = expand('%')
  if s:current_file_name == ''
    echoerr 'You need to save the file first to rename. Use :w <new name>'
    return
  endif
  let new_name = input('Rename file: ', s:current_file_name)
  exec ':Rename ' . new_name
endfunction 

" Replace all characters
function! Irmak#ReplaceAllCharsInFile(old_char, new_char)
  execute ":%s/" . a:old_char . "/" . a:new_char . "/ge"
endfunction

" Substitude Turkish chars
function! Irmak#SubstituteTurkishChars()
  call Irmak#ReplaceAllCharsInFile("Ý", "İ")
  call Irmak#ReplaceAllCharsInFile("ý", "ı")

  call Irmak#ReplaceAllCharsInFile("Þ", "Ş")
  call Irmak#ReplaceAllCharsInFile("þ", "ş")

  call Irmak#ReplaceAllCharsInFile("Ð", "Ğ")
  call Irmak#ReplaceAllCharsInFile("ð", "ğ")

  let filename=expand("%:t:r")
  let extension=expand("%:e")
  execute "w! ++enc=utf-8 " . filename . "." . extension
endfunction


" Format json file
function! Irmak#FormatJSON()
  :%!python -m json.tool
endfunction

function! Irmak#FormatXML()
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


