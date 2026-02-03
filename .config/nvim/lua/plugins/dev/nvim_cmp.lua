return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- buffer source 
        "hrsh7th/cmp-path", -- path source
        "L3MON4D3/LuaSnip", -- snippet engine (sends snippets to cmp-luasnip)
        "saadparwaiz1/cmp_luasnip", -- luasnip source for nvim-cmp (sends snippets from luasnip to nvim-cmp)
        "rafamadriz/friendly-snippets", -- snippets source (sends snippets to luasnip)
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind-nvim", -- vs-code like pictograms 
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    preset = 'codicons',
                    -- prevent the popup from showing more than 50 characters
                    maxwidth = {
                        menu = 50, -- leading text (labelDetails)
                        abbr = 50, -- actual suggestion item
                    },
                    ellipsis_char = '...', -- show ellipsis when the popup exceeds maxwidth
                    menu = {
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        path = "[Path]",
                    },
                    before = function(entry, vim_item)
                        return vim_item
                    end
                }),
            },

            completion = {
                completeopt = "menu,menuone,noinsert,noselect", -- "preview,popup"
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-u>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<C-c>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = false,
                }),
                ["<C-o>"] = cmp.mapping.confirm({
                    select = false,
                }),
            }),

            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "luasnip" },
            },
        })
    end,
}
