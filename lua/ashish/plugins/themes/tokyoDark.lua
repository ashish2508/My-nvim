return {
  "tiagovla/tokyodark.nvim",
  config = function()
    require('tokyodark').setup({
      transparent_background = false, -- Resolved conflict: set background to transparent
      gamma = 1.00,                   -- adjust the brightness of the theme
      saturation = 1.00,
      brightness = 2.00,
      styles = {
        comments = { italic = true },                                        -- style for comments
        keywords = { italic = false, bold = true },                          -- style for keywords
        identifiers = { italic = true },                                     -- style for identifiers
        functions = {},                                                      -- style for functions
        variables = {},                                                      -- style for variables
      },
      custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
      custom_palette = {} or function(palette) return {} end,                -- extend palette
      terminal_colors = true,
    })
    --vim.cmd [[colorscheme tokyodark]] -- Uncomment this line if you want to set the colorscheme
  end,
}
