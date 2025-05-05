return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1200,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup {
      flavour = "frappe", -- latte, frappe, macchiato, mocha
      term_colors = true,
      transparent_background = true,
      no_italic = true,
      no_bold = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
    }
    -- Set the colorscheme to catppuccin (mocha flavor)
    --vim.cmd("colorscheme catppuccin")
  end,
}
