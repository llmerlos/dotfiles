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
endif

set noswapfile
set incsearch
set ignorecase
set smartcase
set clipboard^=unnamedplus

" REMAPS
let mapleader=" "

" BUFFER
nnoremap <silent>   <C-I>   :bp<CR>
nnoremap <silent>   <C-O>   :bn<CR>
nnoremap <silent>   <C-W>   :bd<CR>

"" MISC
nnoremap    Q           @
nnoremap    <leader>m   `
nnoremap    U           <C-R>

"" SCROLL
noremap     <C-d>       12jzz
noremap     <C-u>       12kzz

"" SEARCH
noremap     <leader>sh  :nohls<CR>
nnoremap    <leader>sr  :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>

"" CONFLICTING KEYMAPS
nnoremap    <leader><leader>a   gg0vG$    
nnoremap    <leader><leader>v   <C-v>

"" BLOCK INDENT
vnoremap    >           >gv
vnoremap    <lt>        <lt>gv
vnoremap    <Tab>       >gv
vnoremap    <s-Tab>     <lt>gv
nnoremap    <Tab>       >>
nnoremap    <s-Tab>     <lt><lt>

"" MOVE LINES
nnoremap    <M-Up>      :m .-2<CR>==
nnoremap    <M-Down>    :m .+1<CR>==
vnoremap    <M-Up>      :m '<-2<CR>gv
vnoremap    <M-Down>    :m '>+1<CR>gv

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
nnoremap    <leader>$   mr$x`r
vnoremap    <leader>;   :'<'>norm A;<CR>
vnoremap    <leader>,   :'<'>norm A,<CR>
vnoremap    <leader>.   :'<'>norm A.<CR>
vnoremap    <leader>$   :'<'>norm $x<CR>

"" Checkbox ( https://marcelfischer.eu/blog/2019/checkbox-regex/ )
noremap    <leader>ti  :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze./[<space>]<space>/<CR> <bar> :nohls<CR>
noremap    <leader>tc  :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze./[x]<space>/<CR> <bar> :nohls<CR>
noremap    <leader>td  :s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze.//<CR> <bar> :nohls<CR>

" Plugins
" if g:ENV_IS_NVM " Should be LUA but not plugins in VSC for now
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
        'RRethy/nvim-base16',
        lazy=false,
        priority=1000,
        config = function()
            require('base16-colorscheme').setup({
                base00 = '#2a2c2d',
                base01 = '#31353a',
                base02 = '#373B41',
                base03 = '#676B79',
                base04 = '#BBBBBB',
                base05 = '#E6E6E6',
                base06 = '#F8F8F8',
                base07 = '#FDFDFD',
                base08 = '#FFCC95',
                base09 = '#FFB86C',
                base0A = '#BCAAFE',
                base0B = '#19F9D8',
                base0C = '#B084EB',
                base0D = '#6FC1FF',
                base0E = '#FF75B5',
                base0F = '#808080',
            })
        end
    }

-- IDE-like
--------------------------------------------------------------------------------
    pl_telescope = {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        keys = {
            {'<leader>fp', '<cmd>Telescope find_files<cr>', desc = 'TSCP Find Files'},
            {'<leader>fs', '<cmd>Telescope live_grep<cr>', desc = 'TSCP Live Grep'},
            {'<leader>fe', '<cmd>Telescope file_browser<cr>', desc = 'TSCP File Browser'},
            {'<leader>fw', ':lua require"telescope".extensions.project.project{}<CR>', desc = 'TSCP Projects'},
        },
        config = function(_, opts)
            require('telescope').setup{}
            require("telescope").load_extension "file_browser"
            require("telescope").load_extension "project"
        end,
    }
    
    pl_files = {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
    }
    
    pl_project = {
        'nvim-telescope/telescope-project.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-telescope/telescope-file-browser.nvim' }
    }
    
    pl_tabline = { 
        'echasnovski/mini.tabline', 
        version = '*',
        config = function(_, opts)
            require('mini.tabline').setup(opts)
        end,
    }

    pl_treesitter = {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        opts = {
            ensure_installed =  { 'lua', 'vim', 'vimdoc', 'c', 'rust' },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    }

-- Text edit
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
    
    pl_surround = { 
        'echasnovski/mini.surround', 
        version = '*',
        config = function(_, opts)
            require('mini.surround').setup(opts)
        end,
    }

EOF
endif

if g:ENV_IS_VSC
    nnoremap    <leader>sr  :%s/\<<C-r><C-w>\>/<C-r><C-w>
    nnoremap    <leader>sw  <Cmd>call VSCodeNotify('actions.find', { 'searchString': expand('<cword>')})<CR>

    nnoremap    gc          <Plug>VSCodeCommentaryLine
    vnoremap    gc          <Plug>VSCodeCommentary

    nnoremap    <leader>rs <Cmd>call VSCodeNotify('workbench.action.debug.run')<CR>
    nnoremap    <leader>rd <Cmd>call VSCodeNotify('workbench.action.debug.start')<CR>
    
    lua require('lazy').setup({pl_align, pl_jump, pl_surround})
endif

if g:ENV_IS_NVM
    lua require('lazy').setup({pl_theme, pl_files, pl_project, pl_telescope, pl_tabline, pl_treesitter, pl_align, pl_comment, pl_jump, pl_surround})
endif

if g:ENV_IS_NVD
    set guifont=FiraCode\ Nerd\ Font\ Mono:h13
    let g:neovide_cursor_animation_length = 0.05
    let g:neovide_refresh_rate = 165
    let g:neovide_refresh_rate_idle = 5
endif
