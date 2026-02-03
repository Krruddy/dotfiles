return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = {
                    horizontal = {
                        height = 0.95,
                        width = 0.95,
                        preview_width = 0.6,
                    },
                    vertical = {
                        height = 0.8,
                        width = 0.7,
                        prompt_position = "top",
                        preview_height = 0.7,
                    },
                },
                -- winblend = 1,
                mappings = {
                    i = {
                        -- To move the cursor in the picker
                        ["<C-j>"] = require('telescope.actions').move_selection_next,
                        ["<C-k>"] = require('telescope.actions').move_selection_previous,
                        -- To select the current entry
                        ["<C-o>"] = require('telescope.actions').file_edit,
                        -- To multi select entries
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    file_ignore_patterns = { "^.git/", "^.idea/", "^.vscode/" },  -- Ignore .git, .idea, .vscode directories
                }
            }
        }
        local builtin = require('telescope.builtin')
        -- A mappingthat greps the current selection
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope omni grep' })
        vim.keymap.set('n', '<leader>fb', function() builtin.buffers({ sort_lastused = true }) end, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<C-b>', function() builtin.buffers({ sort_lastused = true }) end, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find, { desc = 'Telescope buffer grep' })
        vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find, { desc = 'Telescope buffer grep' })
        vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Telescope git commit' })
        vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Telescope registry' })
        vim.keymap.set('n', '<S-r>', builtin.registers, { desc = 'Telescope registry' })
    end
}
