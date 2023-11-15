" ENVIRONMENT DETECT
let g:ENV_IS_LUA = has('nvim')
let g:ENV_IS_VSC = exists('g:vscode')
let g:ENV_IS_NVD = exists('g:neovide')
let g:ENV_IS_NVM = g:ENV_IS_LUA && !g:ENV_IS_VSC 
let g:ENV_IS_ITJ = has('ide')
let g:ENV_IS_VIM = !g:ENV_IS_LUA && !g:ENV_IS_ITJ

" OPTIONS
set nocompatible

if !g:ENV_IS_VSC && !g:ENV_IS_ITJ
    syntax on
    filetype plugin indent on
    set title

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
    
    set termguicolors
    set splitright
    set splitbelow

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

" REMAPS
let mapleader=" "
set wildcharm=<Tab>

" SAD I KNOW
noremap  <silent>   <C-S>   :w<CR>

"" BLOCK INDENT
vnoremap    >           >gv
vnoremap    <lt>        <lt>gv
vnoremap    <Tab>       >gv
vnoremap    <S-Tab>     <lt>gv
inoremap    <S-Tab>     <C-d>

" BUFFER
nnoremap <silent>   <leader><Tab> :b <Tab>
nnoremap <silent>   <C-I>   :bp<CR>
nnoremap <silent>   <C-O>   :bn<CR>
nnoremap <silent>   <C-Q>   :bd<CR>

"" MISC
nnoremap    U           <C-R>
nnoremap    <silent> <leader>xc  :echo ''<CR>
noremap     <silent> <leader>xs  :nohls<CR>
noremap     <C-E>  :Ex<CR>

"" SCROLL
noremap     <C-d>       12jzz
noremap     <C-u>       12kzz

"" SEARCH
nnoremap    <leader>sr  :%s/\<<C-r><C-w>\>/<C-r><C-w>

"" CONFLICTING KEYMAPS
nnoremap    <leader><leader>a   gg0vG$    
nnoremap    <leader><leader>v   <C-v>

"" MOVE LINES
nnoremap    <A-Up>      :m .-2<CR>==
nnoremap    <A-Down>    :m .+1<CR>==
vnoremap    <A-Up>      :m '<-2<CR>gv
vnoremap    <A-Down>    :m '>+1<CR>gv

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
nnoremap    <leader>dd  dd
noremap     <leader>D   D
vnoremap    p           "_dP

"" APPEND ,;. TO END OF LINE
nnoremap    <leader>;   mrA;<ESC>`r
nnoremap    <leader>,   mrA,<ESC>`r
nnoremap    <leader>.   mrA.<ESC>`r
nnoremap    <leader>$   mr$"_x`r
vnoremap    <leader>;   :'<'>norm A;<CR>
vnoremap    <leader>,   :'<'>norm A,<CR>
vnoremap    <leader>.   :'<'>norm A.<CR>
vnoremap    <leader>$   :'<'>norm $"_x<CR>

"" Checkbox ( https://marcelfischer.eu/blog/2019/checkbox-regex/ )
noremap    <leader>ti  :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze./[<space>]<space>/<CR> <bar> :nohls<CR>
noremap    <leader>tc  :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze./[x]<space>/<CR> <bar> :nohls<CR>
noremap    <leader>td  :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze.//<CR> <bar> :nohls<CR>

"" Textmode
function WordWrapModeON()
    set wrap
    set linebreak
    noremap <Up>   gk
    noremap <Down> gj
endfunction

function WordWrapModeOFF()
    set nowrap
    set nolinebreak
    noremap <Up>   <Up>
    noremap <Down> <Down>
endfunction

noremap <leader>wwe    <Cmd>call WordWrapModeON()<CR>
noremap <leader>wwd    <Cmd>call WordWrapModeOFF()<CR>

" Plugins
if g:ENV_IS_LUA
lua << EOF
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    end
    vim.opt.rtp:prepend(lazypath)

-- GUI
--------------------------------------------------------------------------------
    pl_theme = {
        'gbprod/nord.nvim',
        lazy=false,
        priority=1000,
        config = function()
            require("nord").setup({})
            vim.cmd.colorscheme("nord")
        end,
    }

-- IDE-like
--------------------------------------------------------------------------------
    pl_telescope = {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        keys = {
            {'<C-p>', '<cmd>Telescope find_files<cr>', desc = 'TSCP Find Files'},
            {'<C-f>', '<cmd>Telescope live_grep<cr>', desc = 'TSCP Live Grep'},
            {'<leader>W', ':lua require"telescope".extensions.project.project{}<CR>',silent=true, desc = 'TSCP Projects'},
        },
        config = function(_, opts)
            require('telescope').setup({})
            require("telescope").load_extension "project"
        end,
    }
    
    pl_project = {
        'nvim-telescope/telescope-project.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim'}
    }
    
    pl_treesitter = {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        opts = {
            ensure_installed =  { 'vim', 'vimdoc', 'c', 'python' },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    }

-- Git
-------------------------------------------------------------------------------
    pl_gitsigns = { 
        'lewis6991/gitsigns.nvim', 
        version = '*',
        config = function(_, opts)
            require('gitsigns').setup(opts)
            vim.api.nvim_command('set statusline+=%#StatusLineR#')
            vim.api.nvim_command("set statusline+=%{get(b:,'gitsigns_head','')!=''?'\\ ('.get(b:,'gitsigns_head','').')\\ ':''}")
            vim.api.nvim_command("set statusline+=%{get(b:,'gitsigns_status','')!=''?'\\ '.get(b:,'gitsigns_status','').'\\ ':''}")
            vim.api.nvim_command('set statusline+=%0*')
        end,
    }

-- Text
--------------------------------------------------------------------------------
    pl_align = { 
        'echasnovski/mini.align', 
        version = '*',
        config = function(_, opts)
            require('mini.align').setup(opts)
        end,
    }

    pl_comment = { 
        'echasnovski/mini.comment', 
        version = '*',
        config = function(_, opts)
            opts.mappings = {
                comment_line = 'gc'
            }
            require('mini.comment').setup(opts)
        end,
    }
    
    pl_jump = { 
        'echasnovski/mini.jump', 
        version = '*',
        config = function(_, opts)
            require('mini.jump').setup(opts)
        end,
    }

EOF
endif

if g:ENV_IS_VSC
    nunmap      gcc
    nnoremap    gc          <Plug>VSCodeCommentaryLine

    lua require('lazy').setup({pl_align, pl_jump})
endif

if g:ENV_IS_NVM
    lua require('lazy').setup({pl_theme, pl_project, pl_telescope, pl_treesitter, pl_gitsigns, pl_align, pl_comment, pl_jump})
endif
