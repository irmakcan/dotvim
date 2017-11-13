" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Automatically wrap at 72 characters and spell check git commit messages
setlocal textwidth=72
setlocal spell

