return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    -- see below for full list of optional dependencies 👇
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        require("obsidian").setup{
            workspaces = {
                {
                    name = "School",
                    path = "~/Documents/ENSEEIHT",
                },
                --{
                --    name = "Research",
                --    path = "~/Documents/Research",
                --},
            },

            daily_notes = {
                -- Optional, if you want to change the date format for the ID of daily notes.
                date_format = "%d-%m-%Y",
                -- Optional, if you want to change the date format of the default alias of daily notes.
                -- alias_format = "%B %-d, %Y",
            },

            sort_by = nil,

            picker = {
                note_mappings = {
                    -- Insert a link to the selected note.
                    insert_link = "<C-l>",
                },
                tag_mappings = {
                    -- Add tag(s) to current note.
                    tag_note = "<C-x>",
                    -- Insert a tag at the current location.
                    insert_tag = "<C-l>",
                },
            },

            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                -- Toggle check-boxes.
                ["<leader>ch"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
                -- Smart action depending on context, either follow link or toggle checkbox.
                ["<cr>"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { buffer = true, expr = true, buffer = true },
                },
            },

            -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
            -- URL it will be ignored but you can customize this behavior here.
            ---@param url string
            follow_url_func = function(url)
              -- Open the URL in the default web browser.
              vim.fn.jobstart({"open", url})  -- Mac OS
              -- vim.fn.jobstart({"xdg-open", url})  -- linux
              -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
              -- vim.ui.open(url) -- need Neovim 0.10.0+
            end,

            -- Stop obsidian.nvim from touching YAML headers on save
            disable_frontmatter = true,

        }

        -- A function used to open obsidian when using WSL
        _G.open_obsidian_wsl = function ()

            local client = require("obsidian").get_client()
            local vault_name = client:vault_name()
            local bufname = vim.api.nvim_buf_get_name(0)
            local file_name = vim.fn.fnamemodify(bufname, ":t")

            -- Open the Windows version of Obsidian
            -- local command = 'powershell.exe -Command "Start-Process \\"obsidian://adv-uri?vault=' .. vault_name .. '&filename=' .. file_name .. '\\""'

            -- Open the WSL version of Obsidian
            local command = 'xdg-open "obsidian://adv-uri?vault=' .. vault_name .. '&filename=' .. file_name .. '"'

           vim.fn.jobstart(command, {
               on_exit = function(_, exit_code)
                   if exit_code ~= 0 then
                       print("Failed to open Obsidian")
                   end
               end,
           })
        end

        vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianOpen<CR>', { desc = 'Open note in the Obsidian' })
        -- vim.api.nvim_set_keymap('n', '<leader>oo', ':lua open_obsidian_wsl()<CR>', {noremap = true, silent = true, desc = 'Open note in the Obsidian' })
        vim.keymap.set('n', '<leader>on', '<cmd>ObsidianNew<CR>', { desc = 'Create a new note' }) -- Not goof because new
        vim.keymap.set('n', '<leader>or', '<cmd>ObsidianRename<CR>', { desc = 'Rename note' })
        vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianTOC<CR>', { desc = 'Table of content' })
        vim.keymap.set('n', '<leader>ol', '<cmd>ObsidianLinks<CR>', { desc = 'List links in current buffer' })
        vim.keymap.set('n', '<leader>ow', '<cmd>ObsidianWorkspace<CR>', { desc = 'Switch to another workspace' })
        vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<CR>', { desc = 'List references to current buffer' })
        -- vim.keymap.set('n', '<leader>ff', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Find note in vault' })

    end,
}
