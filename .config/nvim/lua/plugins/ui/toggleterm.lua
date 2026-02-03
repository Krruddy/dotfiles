return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup{
            close_on_exit = false,
            persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
            shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
            shading_factor = '-90', -- the percentage by which to lighten dark terminal background, default: -30
            shading_ratio = '-3', -- the ratio of shading factor for light/dark terminal background, default: -3

            -- open_mapping = [[<C-t]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
            direction = 'float',

            float_opts = {
                border = 'curved',
                title_pos = 'left',
                zindex = 1,

                -- Fullscreen Terminal
--                 height = 30,
--                 width = 142,
                -- Floating Arch Terminal
                -- height = 27,
                -- width = 125,
                -- Main Display Terminal
                -- 4k Monitor
                height = 42,
                width = 190,
                -- Laptop
                -- height = 30,
                -- width = 130,
            },

--             -- Floating Arch Terminal
--             float_opts = {
--                 border = 'curved',
--                 title_pos = 'left',
--                 zindex = 1,
--                 -- height = 42,
--                 -- width = 150,
--                 -- winblend = 10,
--             },
            highlights = {
                -- highlights which map to a highlight group name and a table of it's values
                -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
                Normal = {
                    -- guibg = "-20",
                },
                NormalFloat = {
                    -- link = 'Normal'
                },
                FloatBorder = {
                    -- guifg = "blue",
                    -- guibg = "black",
                },
            },
        }

        local Terminal  = require('toggleterm.terminal').Terminal
        -- function _lazygit_toggle()
        -- local lazygit = Terminal:new({
        --       cmd = "lazygit",
        --       direction = "float",
        --       hidden = true,
        --       name = "lazygit",
        --       display_name = "lazygit",
        --       on_open = function(term)
        --         vim.cmd("startinsert!")
        --         vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "<cmd>close<CR>", {noremap = true, silent = true})
        --       end,
        --       on_close = function(term)
        --         vim.cmd("startinsert!")
        --       end,

        -- })
        --     lazygit:toggle()
        -- end


        local vim = vim
        local opts = { noremap = true, silent = true }
        local notify = require("notify")

        -- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", opts)
        vim.keymap.set('n', '<C-t>', '<cmd>ToggleTerm<cr>', opts)
        vim.keymap.set('t', '<esc>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '²', [[<Cmd>wincmd k<CR>]], opts)

        -- Send the currently selected text to the terminal, and show the terminal
        vim.keymap.set("v", "<space>sl", function()
            require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
            vim.cmd("ToggleTerm")
            vim.api.nvim_feedkeys("i", "n", false)
            notify('Yanked to terminal.', 'info', {title = 'Yank', timeout = 30})
        end, { noremap = true, silent = true, desc = "Send visual lines to terminal" })
        vim.keymap.set("v", "<space>ss", function()
            require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
            vim.cmd("ToggleTerm")
            notify('Copilot enabled', 'info', {title = 'Copilot', timeout = 30})
        end, { noremap = true, silent = true, desc = "Send visual selection to terminal" })

        -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { noremap = true, silent = true })
        -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { noremap = true, silent = true })
        -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { noremap = true, silent = true })
        -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { noremap = true, silent = true })
        -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })
    end,
}

