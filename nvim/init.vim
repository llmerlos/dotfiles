" ENVIRONMENT DETECT
let g:env = {'lua' :  has('nvim')}
let g:env.vsc = exists('g:vscode')
let g:env.nvd = exists('g:neovide')
let g:env.nvm = g:env.lua && !env.vsc 
let g:env.itj = has('ide')
let g:env.vim = !g:env.lua && !env.itj

" OPTIONS
set nocompatible
set viminfo="NONE"

if !g:env.vsc && !g:env.itj
    syntax on
    filetype plugin indent on
    set title
    set mouse=a
    set termguicolors

    set number
    set relativenumber

    set smartindent
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    
    set nowrap
    set scrolloff=8
    
    set splitright
    set splitbelow

    let g:netrw_banner=0

    "" STATUS LINE
    function! Statusline_color_mode()
        let l:color = get({'I': '#DiffAdd#', 'V': '#DiffChange#', "\<C-V>": '#DiffChange#', 
        \ 'C': '#DiffDelete#', 'T': '#DiffText#', 'R': '#Search#'}, toupper(mode()), '#StatusLineR#')
        return '%' . l:color . '%2{mode()} %0*'
    endfunction
    
    augroup statusline
        autocmd!
        autocmd VimEnter,ColorScheme * exec 'hi StatusLineR guifg=' .  synIDattr(hlID('statusline'),'bg'). ' guibg=' . synIDattr(hlID('statusline'),'fg')
    augroup END

    set noshowmode
    set laststatus=2
    set statusline=
    set statusline+=%{%Statusline_color_mode()%}                "" current mode
    set statusline+=\ [%n]                                      "" buffer num
    set statusline+=\ %<%F\ %h%m%r                              "" full path fielname + tag
    set statusline+=%=                                  "" align right after this
    set statusline+=%{&filetype}                                "" file type
    set statusline+=\ %{&fileencoding?&fileencoding:&encoding}  "" file encoding
    set statusline+=\ %-(\ %l:%c%V\ %)                          "" line:column(visual column)

endif

set noswapfile
set incsearch
set ignorecase
set smartcase
set clipboard^=unnamedplus

set path+=**
set gp=rg\ -n

" REMAPS
let mapleader=" "
set wildcharm=<Tab>

" CONFIG
noremap    <leader>vr         :source $MYVIMRC<CR>
noremap    <leader>ve         :e $MYVIMRC<CR>

" SEARCH (Replaced by plugins)
noremap    <C-p>              :find *
noremap    <C-f>              :grep<space>

" SAD I KNOW
noremap  <silent>             <C-S>   :w<CR>

"" BLOCK INDENT
vnoremap    >                 >gv
vnoremap    <lt>              <lt>gv
vnoremap    <Tab>             >gv
vnoremap    <S-Tab>           <lt>gv
inoremap    <S-Tab>           <C-d>

" BUFFER
nnoremap <silent><leader><Tab> :b <Tab>

"" MISC
nnoremap    U                 <C-R>
noremap     <leader>h         :set nohls<CR>
noremap     <leader>cd        :cd %:h<CR>

"" SCROLL
noremap     <C-d>             12j
noremap     <C-u>             12k

"" CONFLICTING KEYMAPS
nnoremap    <leader><leader>a gg0vG$
nnoremap    <leader><leader>v <C-v>

"" MOVE LINES
nnoremap    <A-Up>            :m .-2<CR>==
nnoremap    <A-Down>          :m .+1<CR>==
vnoremap    <A-Up>            :m '<-2<CR>gv
vnoremap    <A-Down>          :m '>+1<CR>gv

"" CLIPBOARD
noremap     c                 "_c
nnoremap    cc                "_S
noremap     C                 "_C
noremap     s                 "_s
noremap     S                 "_S
noremap     d                 "_d
nnoremap    dd                "_dd
noremap     D                 "_D
noremap     x                 "_x
noremap     X                 "_X
noremap     <leader>c         c
nnoremap    <leader>cc        cc
noremap     <leader>C         C
noremap     <leader>d         d
nnoremap    <leader>dd        dd
noremap     <leader>D         D
vnoremap    p                 "_dP

"" APPEND ,;. TO END OF LINE
nnoremap    <leader>;         mrA;<ESC>`r
nnoremap    <leader>,         mrA,<ESC>`r
nnoremap    <leader>.         mrA.<ESC>`r
nnoremap    <leader>$         mr$"_x`r
vnoremap    <leader>;         :'<'>norm A;<CR>
vnoremap    <leader>,         :'<'>norm A,<CR>
vnoremap    <leader>.         :'<'>norm A.<CR>
vnoremap    <leader>$         :'<'>norm $"_x<CR>

"" VSCODE BINDINGS
if g:env.vsc
    noremap <leader>bl <Cmd>lua require('vscode-neovim').update_config({"editor.rulers"}, {{4,8,12,16,20,24,28,32,36,40,44,48,52,56,60,64}}, "global")<CR>
    noremap <leader>bh <Cmd>lua require('vscode-neovim').update_config({"editor.rulers"}, {{}}, "global")<CR>
    noremap <leader>vr <Cmd>lua require('vscode-neovim').action("workbench.action.restartExtensionHost")<CR>
    noremap <leader>ve :Edit $MYVIMRC<CR>
endif

" SNIPS
"" Checkbox ( https://marcelfischer.eu/blog/2019/checkbox-regex/ )
noremap    <leader>ti    :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze./[<space>]<space>/<CR> <bar> :nohls<CR>
noremap    <leader>tc    :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze./[x]<space>/<CR> <bar> :nohls<CR>
noremap    <leader>td    :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze.//<CR> <bar> :nohls<CR>

"" Boolean Toggle
noremap    -             :call ToggleBoolean()<CR>
function! ToggleBoolean()
    let line = getline(".")
    let new_line = line

    let toggle_table = [ ['True', 'False'] , ['true', 'false'], ['0', '1']]

    for [a_value, b_value] in toggle_table
        if stridx(line, b_value) != -1
            let new_line = substitute(line, '\C' . b_value, a_value, '')
            break
        elseif stridx(line, a_value) != -1
            let new_line = substitute(line, '\C' . a_value, b_value, '')
            break
        endif
    endfor
    
    call setline(".", new_line)
endfunction

"" Textmode
noremap    <leader>ww    :call WordWrapMode()<left>
function! WordWrapMode(activate)
    if a:activate
        set wrap
        set linebreak
        noremap <Up>   gk
        noremap <Down> gj
    else
        set nowrap
        set nolinebreak
        noremap <Up>   <Up>
        noremap <Down> <Down>
    endif
endfunction

" PLG 
let g:data_dir = g:env.lua ? stdpath('data') . '/site' : '~/.vim'
let plug_installed = ! empty(glob(data_dir . '/autoload/plug.vim'))

function! PLGSetup()
    execute '!curl -fLo '. g:data_dir . '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endfunction
:command PlugSetup call PLGSetup()<CR>

if plug_installed
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

    "" Commentary: gcc, gc 
    Plug 'tpope/vim-commentary', Cond(!g:env.vsc)

    "" Telescope: Fuzzy Finding only on Neovim
    Plug 'nvim-lua/plenary.nvim', Cond(g:env.nvm)
    Plug 'nvim-telescope/telescope.nvim', Cond(g:env.nvm, { 'tag': '0.1.6' })
    if g:env.nvm
        nnoremap <C-p> :Telescope find_files<CR>
        nnoremap <C-f> :Telescope live_grep<CR>
        nnoremap <leader><C-p> :Telescope builtin<CR>
    endif

    call plug#end()
endif
