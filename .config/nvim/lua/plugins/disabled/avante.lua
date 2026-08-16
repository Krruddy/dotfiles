return {
  "yetone/avante.nvim",
  enabled = false,
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    -- for example
    provider = "gemini",
    providers = {
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-1.5-flash",
        timeout = 60000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
            max_tokens = 65536,
          },
      },
      deepseek = {
        endpoint = "https://api.deepseek.com",
        model = "deepseek-chat",
        timeout = 60000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
            max_tokens = 65536,
          },
      },
      -- claude = {
      --   endpoint = "https://api.anthropic.com",
      --   model = "claude-sonnet-4-20250514",
      --   timeout = 30000, -- Timeout in milliseconds
      --     extra_request_body = {
      --       temperature = 0.75,
      --       max_tokens = 20480,
      --     },
      -- },
      -- moonshot = {
      --   endpoint = "https://api.moonshot.ai/v1",
      --   model = "kimi-k2-0711-preview",
      --   timeout = 30000, -- Timeout in milliseconds
      --   extra_request_body = {
      --     temperature = 0.75,
      --     max_tokens = 32768,
      --   },
      -- },
    },
  },
-- init = function()
--     -- This autocmd ensures highlights are reset even after colorscheme changes
--     vim.api.nvim_create_autocmd("ColorScheme", {
--       pattern = "*",
--       callback = function()
--         -- 1. Keep the main Sidebar background transparent
--         vim.api.nvim_set_hl(0, "AvanteSidebarNormal", { bg = "NONE", fg = "NONE" })
--         
--         -- 2. Keep floating windows transparent (Optional: remove this if it breaks other plugins like Telescope)
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
-- 
--         -- 3. REMOVED: The lines that forced titles to be transparent. 
--         -- Now Avante will use its default colorful block headers.
--       end,
--     })
--   end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

