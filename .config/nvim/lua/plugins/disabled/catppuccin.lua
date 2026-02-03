return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = false,
    config = function()
        require("catppuccin").setup({
        transparent_background = true,
        })
    end,
}
