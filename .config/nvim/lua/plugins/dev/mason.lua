return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig",
    -- Make sure lspconfig is loaded
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- Setup mason first with all packages
    require("mason").setup {
      ensure_installed = {
        "java-debug-adapter", -- Java debugging support
        "java-test", -- Java test framework support (JUnit, TestNG)
      },
    }

    local mason_lspconfig = require("mason-lspconfig")

    -- LSP servers only for mason-lspconfig
    local lsp_servers = {
      "pyright",
      "eslint", -- This is a linter, not an LSP. Consider none-ls or eslint.nvim
      "lua_ls",
      "marksman",
      -- "tsserver", -- NOTE: 'ts_ls' is deprecated, 'tsserver' is the correct one
      "tailwindcss",
      "clangd",
      "ocamllsp",
      "jdtls", -- Mason will install jdtls
      "terraformls",
    }

    local linters = {
          "tflint",
        }

    mason_lspconfig.setup({
      ensure_installed = lsp_servers,

      -- This is the new, modern way.
      -- It tells mason-lspconfig to automatically call vim.lsp.enable()
      -- for all servers it installs.
      automatic_enable = {
        -- We MUST exclude jdtls here, because your `jdtls.lua`
        -- file handles its setup manually.
        exclude = { "jdtls" },
      },
    })
    -- We have removed the entire `mason_lspconfig.setup_handlers` block
    -- as it is deprecated and was causing your error.

    vim.keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = "Open Mason menu" })
  end,
}
