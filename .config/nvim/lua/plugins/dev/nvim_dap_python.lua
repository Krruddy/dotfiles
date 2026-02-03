return {
    "mfussenegger/nvim-dap-python",
    enabled = false,
    ft = "python",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_python = require("dap-python")
        
        -- Setup dap-ui
        dapui.setup()
        
        -- Setup Python debugger
        -- Automatically find Python interpreter from virtual environment
        local function get_python_path()
            -- Check for .venv in current directory
            local venv_path = vim.fn.getcwd() .. '/.venv/bin/python'
            if vim.fn.executable(venv_path) == 1 then
                return venv_path
            end
            
            -- Check VIRTUAL_ENV
            local env_path = os.getenv('VIRTUAL_ENV')
            if env_path then
                return env_path .. '/bin/python'
            end
            
            -- Fallback to system python
            return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
        end
        
        dap_python.setup(get_python_path())
        
        -- Auto open/close dap-ui
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
        
        -- Keybindings for debugging
        local keymap = vim.keymap
        
        -- Debug session controls
        keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
        keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue debugging" })
        keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
        keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
        keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
        keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
        keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last debug session" })
        keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate debug session" })
        
        -- Python-specific debug methods
        keymap.set("n", "<leader>dm", dap_python.test_method, { desc = "Debug test method" })
        keymap.set("n", "<leader>dM", dap_python.test_class, { desc = "Debug test class" })
        
        -- DAP UI controls
        keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
        keymap.set("n", "<leader>de", function() dapui.eval() end, { desc = "Evaluate expression" })
        keymap.set("v", "<leader>de", function() dapui.eval() end, { desc = "Evaluate selection" })
    end,
}
