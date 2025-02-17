return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1200,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      term_colors = true,
      transparent_background = false,
      no_italic = false,
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
