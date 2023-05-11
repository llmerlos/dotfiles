return {
    "nvim-neo-tree/neo-tree.nvim",
    branch="v2.x",
--    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        close_if_last_window = true,
        window = {
            mappings = {
                ["<space>"] = "none",
                ["E"] = "expand_all_nodes",
                ["Z"] = "close_all_subnodes",
                ["P"] = {"toggle_preview", config = { use_float = false }}, 
            }
        },
        event_handlers = {
            {
                event = "file_opened",
                handler = function(_) vim.cmd("Neotree close") end,
            },
        },
        sources = {
            "filesystem",
            "buffers",
        },
        filesystem = {
            use_libuv_file_watcher = true,
        }
    },
    keys = {
        { "<leader>e", "<cmd>Neotree focus toggle<cr>", desc = "NT Files"},
        { "<leader>Eb", "<cmd>Neotree focus buffers toggle<cr>", desc = "NT Buffers"},
        { "<leader>Eg", "<cmd>Neotree focus git_status toggle<cr>", desc = "NT Git"},
    }
}
