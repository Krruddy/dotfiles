return {
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			-- Note:
			--     the default search path for `require` is ~/.config/nvim/lua
			--     use a `.` as a path seperator
			--     the suffix `.lua` is not needed

            local mason_ok, mason = pcall(require, "mason")
            if not mason_ok then
            	return
            end
            
            local null_ls_ok, null_ls = pcall(require, "null-ls")
            if not null_ls_ok then
            	return
            end
            
            local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
            if not mason_null_ls_ok then
            	return
            end
            
            mason.setup()
            
            mason_null_ls.setup({
            	-- A list of sources to install if they're not already installed.
            	-- This setting has no relation with the `automatic_installation` setting.
            	ensure_installed = {
            		"black",     -- Python formatter
            		"ruff",      -- Python linter & formatter (faster alternative to flake8, pylint)
            		"isort",     -- Python import sorter
            	},
            	-- Run `require("null-ls").setup`.
            	-- Will automatically install masons tools based on selected sources in `null-ls`.
            	-- Can also be an exclusion list.
            	-- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
            	automatic_installation = false,
            	-- Sources found installed in mason will automatically be set up for null-ls.
            	automatic_setup = true,
            	handlers = {
            		-- Hint: see https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
            		--       to see what sources are available
            		-- Hint: see https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
            		--       to check what we can configure for each source
            		
            		-- Python formatters
            		black = function()
            			null_ls.register(null_ls.builtins.formatting.black.with({
            				extra_args = { "--fast" },
            			}))
            		end,
            		
            		ruff = function()
            			null_ls.register(null_ls.builtins.formatting.ruff)
            			null_ls.register(null_ls.builtins.diagnostics.ruff)
            		end,
            		
            		isort = function()
            			null_ls.register(null_ls.builtins.formatting.isort)
            		end,
            		
            		ocamlformat = function(source_name, methods)
            			null_ls.register(null_ls.builtins.formatting.ocamlformat.with({
            				-- Add more arguments to a source's defaults
            				-- Default: { "--enable-outside-detected-project", "--name", "$FILENAME", "-" }
            				-- Type `ocamlformat --help` in your terminal to check more args
            				extra_args = { "--if-then-else", "vertical" },
            			}))
            		end,
            	},
            })
            
            null_ls.setup()

		end,

}
