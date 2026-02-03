return {
    "neovim/nvim-lspconfig",

    -- Lazy loading: The plugin will be loaded when:
    --  - starting to edit an existing file
    --  - You start to edit a non-existent file
    event = {"BufReadPre", "BufNewFile"},

    -- Forces `cmp-nvim-lsp` to be loaded before `nvim-lspconfig`
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "nvim-telescope/telescope.nvim"
    },
    -- This is the function which will be run when the plugin loads
    config = function()
        -- The default Neovim LSP client has limited capabilities , and does not support snippets or more advanced completion features.
        -- In order to enhance the capabilities of the LSP client we use a Completion Engine (CE) like `nvim-cmp`. The CE aggregates data (from LSPs and other sources), handles the UI, and handles the logic of suggestions.
        -- To make sure that the LSP server is aware of the enhanced capabilities, we pass `cmp_nvim_lsp.default_capabilities()`, a key-value table which contains the capabilities of `nvim-cmp`.
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- This is a callback function that will be run every time an LSP server attaches to a buffer.
        -- Note that this function doesn't do anything as is, it used lower in the code when setting up each server.
        -- - `client` is a lua table that contains information about the LSP server being attached (client.name = "pyright", etc).
        -- - `bufnr` is the buffer number that the LSP server is being attached to.
        local on_attach = function(client, bufnr)
            local keymap = vim.keymap
            local opts = { buffer = bufnr, noremap = true, silent = true }

            opts. desc = "Show LSP references"
            keymap.set("n", "gR", vim.lsp.buf.references, opts)
            -- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "Show LSP definitions"
            keymap. set("n", "gd", vim.lsp.buf.definition, opts)
            -- keymap. set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

            opts.desc = "Show LSP implementations"
            keymap. set("n", "gi", vim.lsp.buf.implementation, opts)
            -- keymap. set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

            opts.desc = "Show LSP type definitions"
            keymap. set("n", "gt", vim.lsp.buf.definition, opts)
            -- keymap. set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            -- opts.desc = "Show buffer diagnostics"
            -- keymap.set("n", "<leader>D", vim.lsp.diagnostic.get_namespace, opts)
            -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

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

        -- Separate setup for pyright, allowing manual pythonPath configuration
        vim.lsp.config("pyright", {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                python = {
                    -- Manually set the path to your Python executable within the virtual environment.
                    -- IMPORTANT: Replace "/path/to/your/project/.venv/bin/python" with your actual path.
                    pythonPath = "/home/ruddy/git/ENSEEIHT-GCP-Spark-Cluster-Project/.venv/bin/python",
                },
            },
        })
        vim.lsp.enable("pyright")

        -- Generic setup for other servers (pyright removed from this list)
        local servers = {"ts_ls", "lua_ls", "marksman", "jdtls", "tailwindcss", "ocamllsp", "clangd"}

        for _, server in ipairs(servers) do
            vim.lsp.config(server, {
                capabilities = capabilities,
                on_attach = on_attach,
            })
            vim.lsp.enable(server)
        end
    end,
}
