return {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
        { "github/copilot.vim" },
        { "nvim-lua/plenary.nvim" },
    },
    enabled = false,
    build = "make tiktoken",
    opts = {
        model = 'gpt-4o',
        auto_insert_mode = true,
        show_help = true,
        question_header = '## User ',
        answer_header = '## Copilot ',
        window = {
            leayout = 'vertical',
            width = 0.4,
            -- layout = 'float',
            -- width = 0.8, -- Proportional width (0-1) or fixed width in columns
            -- height = 0.8, -- Proportional height (0-1) or fixed height in rows
            -- border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
            -- title = '🤖 AI Assistant',
            -- zindex = 100, -- Ensure window stays on top
            -- blend = 10, -- Transparency level (0-100)
        },
          headers = {
            user = '👤 You',
            assistant = '🤖 Copilot',
            tool = '🔧 Tool',
          },

    },
    keys = {
        { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat", mode = { "n", "v" } },
        { "<leader>cq", "<cmd>CopilotChat<cr>", desc = "Copilot Chat", mode = { "n", "v" } },
        { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code", mode = { "n", "v" } },
        { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "Generate tests", mode = { "n", "v" } },
        { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Fix code", mode = { "n", "v" } },
        { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize code", mode = { "n", "v" } },
        { "<leader>cd", "<cmd>CopilotChatDocs<cr>", desc = "Generate docs", mode = { "n", "v" } },
    },
}
