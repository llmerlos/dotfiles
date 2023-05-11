return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function(_, opts)
        require("bufferline").setup({})
    end,
}
