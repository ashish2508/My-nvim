return {
  "ellisonleao/gruvbox.nvim",
  priority = 1200,
  config = function()
    -- Default options:
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = true,
      invert_signs = true,
      invert_tabline = true,
      invert_intend_guides = true,
      inverse = true,    -- invert background for search, diffs, statuslines and errors
      contrast = "soft", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = true,
      transparent_mode = true,
    })
    --vim.cmd("colorscheme gruvbox")
  end,
}
