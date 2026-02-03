return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- Set mappings for the file explorer when attached
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- Custom mappings
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open and Close Explorer")) -- Mapping to open the file and close the explorer
            vim.keymap.set("n", "<C-o>", api.node.open.no_window_picker, opts("Open and Keep Explorer")) -- Mapping to open the file and keep the explorer open
            vim.keymap.set("n", "<leader>tcn", api.tree.change_root_to_node, opts("CD")) -- Mapping to change the root to the node
            vim.keymap.set("n", "<leader>tcp", api.tree.change_root_to_parent, opts("CD Parent")) -- Mapping to change the root to the parent node
            vim.keymap.set("n", "<leader>tf", api.tree.find_file, opts("Jump to current buffer")) -- Mapping to jump to the current buffer
            vim.keymap.set("n", "<leader>tr", api.tree.reload, opts("Reload")) -- Mapping to reload the tree
            vim.keymap.set("n", "<leader>tz", api.tree.expand_all, opts("Expand all nodes")) -- Mapping to expand all nodes
            vim.keymap.set("n", "<leader>tm", api.tree.collapse_all, opts("Collapse all nodes")) -- Mapping to collapse all nodes
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            actions = {
                open_file = {
                    quit_on_open = false, -- Keep the tree open after opening a file
                }
            }
        })
        local nvim_tree = require("nvim-tree.api")

        -- Keymaps
        -- Need to open file with, and without closing NvimTree
        -- Need to open files with the software corresponding to the file type
        -- Leverage the arrow keys to navigate the tree
        vim.keymap.set('n', '<S-t>', nvim_tree.tree.toggle, { desc = 'Toggle NvimTree' })
        vim.keymap.set('n', '<leader>tt', nvim_tree.tree.focus, { desc = 'Focus NvimTree' })

    end,
}
