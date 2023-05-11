" ENVIRONMENT DETECT
let g:ENV_IS_LUA = has('nvim')
let g:ENV_IS_VSC = exists('g:vscode')
let g:ENV_IS_NVM = g:ENV_IS_LUA && !g:ENV_IS_VSC 
let g:ENV_IS_ITJ = has('ide')
let g:ENV_IS_VIM = !g:ENV_IS_LUA && !g:ENV_IS_ITJ

" OPTIONS
set nocompatible

if !g:ENV_IS_VSC && !g:ENV_IS_ITJ
    syntax on
    filetype plugin indent on
    set number
    set relativenumber

    set smartindent
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    
    set nowrap
    set scrolloff=8
    
    set mouse=a
endif

set noswapfile
set incsearch
set ignorecase
set smartcase
set clipboard^=unnamedplus

" REMAPS
let mapleader=" "

"" MISC
nnoremap    Q           @
nnoremap    <leader>m   `
nnoremap    U           <C-R>

"" SCROLL
noremap     <C-d>       12jzz
noremap     <C-u>       12kzz

"" COMMENT
if g:ENV_IS_VSC 
    nnoremap <leader>ct <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>
    vnoremap <leader>ct <Cmd>call VSCodeNotifyVisual('editor.action.commentLine', 1)<CR>
endif

"" RUN
if g:ENV_IS_VSC 
    nnoremap <leader>rs <Cmd>call VSCodeNotify('workbench.action.debug.run')<CR>
    nnoremap <leader>rd <Cmd>call VSCodeNotify('workbench.action.debug.start')<CR>
endif

"" SEARCH
noremap     <leader>sh  :nohls<CR>
nnoremap    <leader>sr  :%s/\<<C-r><C-w>\>/<C-r><C-w>

"" SELECT ALL
nnoremap    <leader><leader>a   gg0vG$    

"" BLOCK INDENT
vnoremap    >           >gv
vnoremap    <lt>        <lt>gv
vnoremap    <Tab>       >gv
vnoremap    <s-Tab>     <lt>gv
nnoremap    <Tab>       >>
nnoremap    <s-Tab>     <lt><lt>

"" CLIPBOARD
noremap     c           "_c
nnoremap    cc          "_S
noremap     C           "_C
noremap     s           "_s
noremap     S           "_S
noremap     d           "_d
nnoremap    dd          "_dd
noremap     D           "_D
noremap     x           "_x
noremap     X           "_X

noremap     <leader>c   c
nnoremap    <leader>cc  cc
noremap     <leader>C   C
noremap     <leader>d   d
nnoremap     <leader>dd  dd
noremap     <leader>D   D

"" APPEND ,;. TO END OF LINE
nnoremap    <leader>;   mrA;<ESC>`r
nnoremap    <leader>,   mrA,<ESC>`r
nnoremap    <leader>.   mrA.<ESC>`r
nnoremap    <leader>/   mr$x`r
vnoremap    <leader>;   :'<'>norm A;<CR>
vnoremap    <leader>,   :'<'>norm A,<CR>
vnoremap    <leader>.   :'<'>norm A.<CR>
vnoremap    <leader>/   :'<'>norm $x<CR>


" FINISH LOADING ENV
if g:ENV_IS_NVM
    lua require("core")
endif