return {
    'preservim/vim-markdown',
    enabled = true,
    config = function()
        -- require('vim_markdown').setup({})
        vim.opt.conceallevel = 2
        vim.opt.linebreak = true
        vim.g.vim_markdown_folding_level = 2
        vim.opt.foldlevelstart = 99
    end,
}
