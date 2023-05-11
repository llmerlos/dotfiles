return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        keys = {
            {'<leader>f', '<cmd>Telescope find_files<cr>', desc = 'TSCP Find Files'},
            {'<leader>Fs', '<cmd>Telescope live_grep<cr>', desc = 'TSCP Live Grep'},
            {'<leader>Fb', '<cmd>Telescope buffers<cr>', desc = 'TSCP Buffers'},
            {'<leader>Fh', '<cmd>Telescope help_tags<cr>', desc = 'TSCP Help'},
        },
        config = function(_, opts)
            require("telescope").setup{}
        end,
    },
    -- {
    --     "nvim-telescope/telescope-file-browser.nvim",
    --     dependencies = {
    --         "nvim-telescope/telescope.nvim",
    --         "nvim-lua/plenary.nvim"
    --     },
    --     config = function(_, opts)
    --         -- require("telescope").setup()
    --         require("telescope").load_extension("file_browser")
    --     end,
    -- }
}
