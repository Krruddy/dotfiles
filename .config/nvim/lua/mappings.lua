local emoticons = require("emoticons")
local notify = require('notify')

local function map(mode, lhs, rhs, opts, notify_opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    if notify_opts then
        notify(notify_opts)
    end
end

-- General
map('n', '<leader>ml', ':Lazy<CR>', { desc = 'Open Lazy menu' })
map('n', '<leader>ss', '<cmd>w!<CR>', { desc = 'Save current buffer' })
map('n', '<leader>h', '<cmd>noh<CR>', { desc = 'Clear search highlights' })
map("v", "<", "<gv", { desc = 'Indent left' })
map("v", ">", ">gv", { desc = 'Indent right' })
map('n', '<F2>', '<', { noremap = true, silent = true, desc = 'Indent left' })
map('i', '<F2>', '<', { noremap = true, silent = true, desc = 'Indent left' })
map('v', '<F2>', '<gv', { noremap = true, silent = true, desc = 'Indent left' })
map('c', '<F2>', '<', { noremap = true, silent = true, desc = 'Indent left' })
map('n', '<F3>', '>', { noremap = true, silent = true, desc = 'Indent right' })
map('i', '<F3>', '>', { noremap = true, silent = true, desc = 'Indent right' })
map('v', '<F3>', '>gv', { noremap = true, silent = true, desc = 'Indent right' })
map('c', '<F3>', '>', { noremap = true, silent = true, desc = 'Indent right' })

-- Resize
map("n", "<S-Up>", ":resize -2<CR>", { desc = 'Resize window' })
map("n", "<S-Down>", ":resize +2<CR>", { desc = 'Resize window' })
map("n", "<S-Left>", ":vertical resize -2<CR>", { desc = 'Resize window' })
map("n", "<S-Right>", ":vertical resize +2<CR>", { desc = 'Resize window' })

-- Buffers
map("n", "<TAB>", ":bn<CR>", { desc = 'Next buffer' })
map("n", "<S-TAB>", ":bp<CR>", { desc = 'Previous buffer' })
map("n", "<leader>bd", ":bd<CR>", { desc = 'Close buffer' })
