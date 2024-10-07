" ENVIRONMENT DETECT
let g:env = {'lua' :  has('nvim')}
let g:env.vsc = exists('g:vscode')
let g:env.itj = has('ide')
let g:env.nvm = g:env.lua && (env.vsc == 0)
let g:env.vim = (g:env.lua == 0) && (env.itj == 0)
let g:env.emb = g:env.vsc || g:env.itj

" OPTIONS
set nocompatible
set viminfo="NONE"
set noswapfile
set incsearch
set ignorecase
set smartcase
set clipboard^=unnamedplus
set path+=**
set gp=rg\ -n
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set scrolloff=8
set splitright
set splitbelow

if g:env.vsc == 0 
    syntax on
    filetype plugin indent on
    set title
    set mouse=a
    set termguicolors
    set number
    set relativenumber
    set nowrap
    "color slate
endif

" REMAPS
let mapleader=" "
set wildcharm=<Tab>

" CONFIG
noremap     <leader>vr         :source $MYVIMRC<CR>
noremap     <leader>ve         :e $MYVIMRC<CR>
if g:env.vsc
    noremap <leader>vr         <Cmd>lua require('vscode-neovim').action("workbench.action.restartExtensionHost")<CR>
    noremap <leader>ve         :Edit $MYVIMRC<CR>
endif

" SEARCH (Replaced by plugins)
noremap    <C-p>               :find *
noremap    <C-f>               :grep<space>

"" BLOCK INDENT
vnoremap    >                  >gv
vnoremap    <lt>               <lt>gv

"" MISC
nnoremap    U                  <C-R>
noremap     <leader>h          :set nohls<CR>
noremap     <leader>cd         :cd %:h<CR>

"" SCROLL & NAVIGATION
noremap     <silent><C-d>      12j
noremap     <silent><C-u>      12k
noremap     <silent><C-l>      :bn<CR>
noremap     <silent><C-h>      :bp<CR>
noremap  <silent><leader><Tab> :b <Tab>

"" CONFLICTING KEYMAPS
noremap     <C-s>              :w<CR>
nnoremap    <leader><leader>a  gg0vG$
nnoremap    <leader><leader>v  <C-v>

"" MOVE LINES
nnoremap    <silent><A-Up>     :m .-2<CR>==
nnoremap    <silent><A-Down>   :m .+1<CR>==
vnoremap    <silent><A-Up>     :m '<-2<CR>gv
vnoremap    <silent><A-Down>   :m '>+1<CR>gv

"" CLIPBOARD
noremap     c                  "_c
nnoremap    cc                 "_S
noremap     C                  "_C
noremap     s                  "_s
noremap     S                  "_S
noremap     d                  "_d
nnoremap    dd                 "_dd
noremap     D                  "_D
noremap     x                  "_x
noremap     X                  "_X
noremap     <leader>c          c
nnoremap    <leader>cc         cc
noremap     <leader>C          C
noremap     <leader>d          d
nnoremap    <leader>dd         dd
noremap     <leader>D          D
vnoremap    p                  "_dP

" SNIPS
"" Boolean Toggle
noremap     -                  :call ToggleBoolean()<CR>
function! ToggleBoolean()
    let line = getline(".")
    let new_line = line

    let toggle_table = [ ['True', 'False'] , ['true', 'false'], ['0', '1']]

    for [a_value, b_value] in toggle_table
        if stridx(line, a_value) != -1
            let new_line = substitute(line, '\C' . a_value, b_value, '')
            break
        elseif stridx(line, b_value) != -1
            let new_line = substitute(line, '\C' . b_value, a_value, '')
            break
        endif
    endfor
    
    call setline(".", new_line)
endfunction

" PLG https://github.com/junegunn/vim-plug?tab=readme-ov-file#installation
let g:data_dir = g:env.lua ? stdpath('data') . '/site' : '~/.vim'
let plug_installed = (empty(glob(data_dir . '/autoload/plug.vim')) == 0)

function! PLGSetup()
    execute '!curl -fLo '. g:data_dir . '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endfunction
:command PlugSetup call PLGSetup()<CR>

if (plug_installed || g:env.itj)
    call plug#begin()
    function! Cond(cond, ...)
        let opts = get(a:000, 0, {})
        return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
    endfunction

    "" Align: gaip
    Plug 'junegunn/vim-easy-align'
    xnoremap ga <Plug>(EasyAlign)
    nnoremap ga <Plug>(EasyAlign)

    "" Surround: cs'", ysiw], ds
    Plug 'tpope/vim-surround'

    "" FZF: Fuzzy finder
    Plug 'junegunn/fzf', Cond(g:env.nvm, { 'do': { -> fzf#install() } })
    Plug 'junegunn/fzf.vim', Cond(g:env.nvm)
    if g:env.nvm
        nnoremap <C-p> :Files<CR>
        nnoremap <C-f> :Rg<CR>
    endif

    call plug#end()
endif
