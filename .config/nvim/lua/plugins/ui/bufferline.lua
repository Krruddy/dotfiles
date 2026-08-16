return {
    'akinsho/bufferline.nvim',
    -- enable = true,
    enabled = function()
        return os.getenv("NVIM_MAN") == nil
    end,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    lazy = false,
    keys = {
        { "<leader>bbp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
        { "<leader>bbP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        { "<leader>bbdr", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
        { "<leader>bbdl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
        { "mbl", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer to the left" },
        { "mbr", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer to the right" },
        { "<TAB>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer (sorted)" },
        { "<S-TAB>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer (sorted)" },
        { "<leader>bd", "<cmd>bdelete<cr>", desc = "Close buffer" },
    },
    opts = {
        options = {
            style = 'underline',
            numbers = 'ordinal',
            diagnostics = 'nvim_lsp',
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true
            },
        },
        },

    },
}
