vim = vim
vim.g.mapleader = " "
vim.g.netrw__liststyle = 4

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.title = true
vim.o.syntax = "ON"
vim.o.compatible = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 15
vim.o.sidescrolloff = 15

vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smartindent = true

-- Set case insensitive search
vim.opt.ignorecase = true

-- If search pattern contains uppercase letters, make it case sensitive
vim.opt.smartcase = true

vim.opt_local.conceallevel = 0

vim.opt.termguicolors = true

vim.g.mkdp_browser = 'wsl-open'

-- Enable setting the terminal title
vim.opt.title = true

-- Set the terminal title string to the current file name
vim.opt.titlestring = "%F"

-- Automatically copy yanked text to the system clipboard
vim.opt.clipboard = "unnamedplus"
