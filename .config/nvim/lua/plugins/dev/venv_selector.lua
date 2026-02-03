return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        "mfussenegger/nvim-dap-python",
    },
    enabled = false,
    branch = "regexp",
    ft = "python",
    config = function()
        require("venv-selector").setup({
            -- Auto select venv on opening Python files
            auto_refresh = true,
            
            -- Search for virtual environments in these directories
            search_venv_managers = true,
            search_workspace = true,
            
            -- Paths to search for virtual environments
            path = {
                vim.fn.getcwd() .. "/.venv",
                vim.fn.getcwd() .. "/venv",
                vim.fn.expand("~/.virtualenvs"),
                vim.fn.expand("~/.pyenv/versions"),
            },
            
            -- Enable support for various venv managers
            poetry = {
                enabled = true,
            },
            pipenv = {
                enabled = true,
            },
            pyenv = {
                enabled = true,
            },
            hatch = {
                enabled = true,
            },
            anaconda = {
                enabled = false,
            },
            
            -- Automatically activate venv when opening Python files
            enable_cached_venvs = true,
            
            -- Show venv in statusline (if lualine is configured)
            name = "VenvSelect",
            
            -- DAP integration
            dap_enabled = true,
        })
        
        -- Keybindings
        vim.keymap.set("n", "<leader>vs", ":VenvSelect<CR>", { desc = "Select virtual environment" })
        vim.keymap.set("n", "<leader>vc", ":VenvSelectCached<CR>", { desc = "Select cached venv" })
        vim.keymap.set("n", "<leader>vd", function()
            local venv = require("venv-selector").venv()
            if venv then
                print("Current venv: " .. venv)
            else
                print("No venv selected")
            end
        end, { desc = "Show current venv" })
    end,
}
