return {
    "github/copilot.vim",

    config = function()

        local notify = require('notify')
        local vim = vim

        -- Disable default tab mapping to avoid conflicts with CopilotChat
        vim.g.copilot_no_tab_map = true
        
        -- Use Shift-Tab for accepting suggestions
        vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
        
        vim.keymap.set('i', '<C-Right>', '<Plug>(copilot-accept-word)')
        vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)')

        local emoticons = require("emoticons")
        local opts = {title = 'Copilot', timeout = 30}

        vim.keymap.set('n', '<leader>cpe', function ()
            vim.api.nvim_command('Copilot enable')
            local rand_opts = opts
            rand_opts.icon = emoticons.get_random_emoticon()
            notify('Copilot enabled', 'info', rand_opts)
        end,
        { desc = 'Enable Copilot' })

        vim.keymap.set('n', '<leader>cpd', function ()
            vim.api.nvim_command('Copilot disable')
            local rand_opts = opts
            rand_opts.icon = emoticons.get_random_emoticon()
            notify('Copilot disabled', 'info', rand_opts)
        end,
        { desc = 'Disable Copilot' })

        vim.keymap.set('n', '<leader>cps', function()
            local output = vim.api.nvim_exec('Copilot status', true)
            local rand_opts = opts
            rand_opts.icon = emoticons.get_random_emoticon()
            notify(output, 'info', rand_opts)
        end,
        { desc = 'Copilot status' })
    end
}
