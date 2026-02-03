require('basic_config')
require("config.lazy")
require('mappings')

vim.cmd([[colorscheme gruvbox-material]])

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  callback = function()
    vim.g.indent_blankline_enabled = false
  end,
})
