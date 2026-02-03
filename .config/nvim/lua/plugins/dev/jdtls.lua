-- This file contains the special configuration for jdtls
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap", -- For Java debugging
  },
  config = function()
    local jdtls = require("jdtls")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    
    -- Get capabilities
    local capabilities_general = cmp_nvim_lsp.default_capabilities()
    
    -- Define on_attach that includes general LSP keybindings
    local function on_attach_general(client, bufnr)
      local keymap = vim.keymap
      local opts = {buffer = bufnr, noremap = true, silent = true}

      -- General LSP keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    -- Helper to get project name for workspace directory
    local function get_project_name()
      local result = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      return result
    end

    -- Get paths to debug and test bundles
    local function get_bundles()
      local bundles = {}
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
      
      -- Try to add java-debug-adapter if installed
      local java_debug_path = mason_path .. "/java-debug-adapter"
      if vim.fn.isdirectory(java_debug_path) == 1 then
        local java_debug_jar = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
        if java_debug_jar ~= "" then
          table.insert(bundles, java_debug_jar)
        end
      end

      -- Try to add java-test if installed
      local java_test_path = mason_path .. "/java-test"
      if vim.fn.isdirectory(java_test_path) == 1 then
        local java_test_jars = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n")
        for _, jar in ipairs(java_test_jars) do
          if jar ~= "" then
            table.insert(bundles, jar)
          end
        end
      end

      return bundles
    end

    -- Configure jdtls
    local jdtls_config = {
      -- Use the general capabilities
      capabilities = capabilities_general,

      -- The command to run jdtls with workspace directory per project
      cmd = {
        "jdtls",
        "-data",
        vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. get_project_name(),
      },

      -- Find the root of the project
      root_dir = require("lspconfig").util.root_pattern(
        ".git",
        "mvnw",
        "gradlew",
        "pom.xml",
        "build.gradle",
        "build.gradle.kts"
      ),

      -- Better settings for Java projects
      settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "interactive",
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          format = {
            enabled = true,
          },
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          completion = {
            favoriteStaticMembers = {
              "org.junit.jupiter.api.Assertions.*",
              "org.junit.Assert.*",
              "org.mockito.Mockito.*",
              "org.mockito.ArgumentMatchers.*",
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
            importOrder = {
              "java",
              "javax",
              "com",
              "org",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
        },
      },

      -- This is the crucial part:
      -- It sets up a unique workspace directory for each project
      on_attach = function(client, bufnr)
        -- 1. Run the *general* on_attach to get all your normal keymaps
        on_attach_general(client, bufnr)

        -- 2. Setup DAP for debugging (with pcall to avoid errors if bundles not loaded)
        pcall(function()
          jdtls.setup_dap({ hotcodereplace = "auto" })
        end)

        -- 3. Setup DAP configurations if dap is available
        local has_dap, dap = pcall(require, "dap")
        if has_dap then
          dap.configurations.java = {
            {
              type = "java",
              request = "attach",
              name = "Debug (Attach) - Remote",
              hostName = "127.0.0.1",
              port = 5005,
            },
          }
        end

        -- 4. Add Java-specific keymaps
        local keymap = vim.keymap
        local opts = { buffer = bufnr, noremap = true, silent = true }

        opts.desc = "JDTLS: Organize Imports"
        keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)

        opts.desc = "JDTLS: Update Project Config"
        keymap.set("n", "<leader>ju", jdtls.update_project_config, opts)

        opts.desc = "JDTLS: Extract Variable"
        keymap.set("v", "<leader>jev", jdtls.extract_variable, opts)

        opts.desc = "JDTLS: Extract Constant"
        keymap.set("v", "<leader>jec", function()
          jdtls.extract_constant(true)
        end, opts)

        opts.desc = "JDTLS: Extract Method"
        keymap.set("v", "<leader>jem", jdtls.extract_method, opts)

        opts.desc = "JDTLS: Go to Super Class"
        keymap.set("n", "gS", jdtls.super_implementation, opts)

        opts.desc = "JDTLS: Run Main Class"
        keymap.set("n", "<leader>jrr", jdtls.run_main_class, opts)

        opts.desc = "JDTLS: Run Test Method/Class"
        keymap.set("n", "<leader>jrt", jdtls.test_class, opts)

        opts.desc = "JDTLS: Run Nearest Test Method"
        keymap.set("n", "<leader>jrn", jdtls.test_nearest_method, opts)

        opts.desc = "JDTLS: Debug Main Class"
        keymap.set("n", "<leader>jdr", jdtls.debug_main_class, opts)

        opts.desc = "JDTLS: Debug Test Method/Class"
        keymap.set("n", "<leader>jdt", jdtls.test_class, opts)

        opts.desc = "JDTLS: Pick Test Method"
        keymap.set("n", "<leader>jpt", jdtls.pick_test, opts)
      end,

      -- Initialize with bundles for debugging/testing
      init_options = {
        bundles = get_bundles(),
      },
    }

    -- This starts the jdtls server
    jdtls.start_or_attach(jdtls_config)
  end,
}
