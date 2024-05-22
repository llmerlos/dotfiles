if exists(':GuiFont')
    GuiFont! JetBrains\ Mono\ NL:h10
endif

if exists(':GuiTabline')
    GuiTabline 1
endif
if exists(':GuiTablineBuffers')
    GuiTablineBuffers 1
endif

if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
