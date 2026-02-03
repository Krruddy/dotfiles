return {
    "nvim-neotest/neotest",
    enabled = false,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Python adapter
        "nvim-neotest/neotest-python",
        -- Optional: add other test adapters as needed
        -- "nvim-neotest/neotest-jest",
        -- "nvim-neotest/neotest-go",
    },
    ft = "python",
    config = function()
        local neotest = require("neotest")
        
        neotest.setup({
            adapters = {
                require("neotest-python")({
                    -- Use the Python path from virtual environment
                    python = function()
                        local venv_path = vim.fn.getcwd() .. '/.venv/bin/python'
                        if vim.fn.executable(venv_path) == 1 then
                            return venv_path
                        end
                        
                        local env_path = os.getenv('VIRTUAL_ENV')
                        if env_path then
                            return env_path .. '/bin/python'
                        end
                        
                        return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
                    end,
                    
                    -- Test runner (pytest is default, can also use unittest)
                    runner = "pytest",
                    
                    -- pytest arguments
                    args = { "--log-level", "DEBUG", "--verbose" },
                    
                    -- Support for pytest-django
                    is_test_file = function(file_path)
                        return vim.endswith(file_path, ".py") and 
                               (vim.startswith(vim.fn.fnamemodify(file_path, ":t"), "test_") or
                                vim.endswith(file_path, "_test.py"))
                    end,
                }),
            },
            
            -- UI configuration
            icons = {
                running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                passed = "✓",
                failed = "✗",
                skipped = "⊘",
                running = "●",
                unknown = "?",
            },
            
            -- Output window
            output = {
                enabled = true,
                open_on_run = true,
            },
            
            -- Summary window
            summary = {
                enabled = true,
                follow = true,
                expand_errors = true,
            },
            
            -- Status signs in the gutter
            status = {
                enabled = true,
                virtual_text = false,
                signs = true,
            },
            
            -- Diagnostic integration
            diagnostic = {
                enabled = true,
            },
            
            -- Floating windows
            floating = {
                border = "rounded",
                max_height = 0.8,
                max_width = 0.9,
            },
        })
        
        -- Keybindings
        local keymap = vim.keymap
        
        -- Run tests
        keymap.set("n", "<leader>tt", function() neotest.run.run() end, { desc = "Run nearest test" })
        keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run test file" })
        keymap.set("n", "<leader>ta", function() neotest.run.run(vim.fn.getcwd()) end, { desc = "Run all tests" })
        keymap.set("n", "<leader>tl", function() neotest.run.run_last() end, { desc = "Run last test" })
        
        -- Debug tests (requires nvim-dap-python)
        keymap.set("n", "<leader>td", function() neotest.run.run({strategy = "dap"}) end, { desc = "Debug nearest test" })
        
        -- Test output
        keymap.set("n", "<leader>to", function() neotest.output.open({enter = true}) end, { desc = "Show test output" })
        keymap.set("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Toggle output panel" })
        
        -- Test summary
        keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle test summary" })
        
        -- Stop running tests
        keymap.set("n", "<leader>tx", function() neotest.run.stop() end, { desc = "Stop running tests" })
        
        -- Watch mode (re-run on file save)
        keymap.set("n", "<leader>tw", function() neotest.watch.toggle() end, { desc = "Toggle watch mode" })
        
        -- Navigation between tests
        keymap.set("n", "[t", function() neotest.jump.prev({status = "failed"}) end, { desc = "Previous failed test" })
        keymap.set("n", "]t", function() neotest.jump.next({status = "failed"}) end, { desc = "Next failed test" })
    end,
}
