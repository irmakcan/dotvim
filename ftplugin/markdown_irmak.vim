" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

if exists(':Tcolorscheme')
  setlocal background=light
  Tcolorscheme solarized
endif

