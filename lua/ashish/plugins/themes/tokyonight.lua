return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000, -- Load it first to apply theme globally
  config = function()
    require("tokyonight").setup({
      style = "night",        -- Options: storm, night, day, moon
      transparent = false,    -- Enable background transparency
      terminal_colors = true, -- Apply colors to terminal
      styles = {
        comments = { italic = true },
        keywords = { italic = true, bold = true },
        functions = { bold = true },
        variables = {},
        sidebars = "dark", -- Sidebar and floating windows style
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal" }, -- Darken these windows
      on_colors = function(colors)
        colors.bg_sidebar = colors.bg_dark
        colors.bg_float = colors.bg_dark
      end,
      on_highlights = function(hl, colors)
        hl.CursorLine = { bg = colors.bg_highlight }             -- Highlight active line
        hl.LineNr = { fg = colors.comment, bg = colors.bg_dark } -- Line numbers color
        hl.CursorLineNr = { fg = colors.orange, bold = true }    -- Current line number
      end,
    })
    --vim.cmd([[colorscheme tokyonight]]) -- Set the colorscheme
  end,
}
