return {
    {
        "echasnovski/mini.surround",
        version = "*",
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },
    {
        "echasnovski/mini.pairs",
        version = "*",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },
    {
        "echasnovski/mini.comment",
        version = "*",
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    }
}
