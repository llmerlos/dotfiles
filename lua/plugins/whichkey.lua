return {
    "folke/which-key.nvim",
    lazy = false,
    keys = {
        {"<leader>H", "<cmd>WhichKey<cr>", desc = "WhichKey"},   
    },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500

        require("which-key").setup({})
    end,
}
