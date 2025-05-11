return
{
  "polirritmico/monokai-nightasty.nvim",
  lazy = false,
  priority = 1200,

  ---@type monokai.UserConfig
  opts = {
    dark_style_background = "default",
    light_style_background = "default",
    markdown_header_marks = true,
    hl_styles = { comments = { italic = false } },
    terminal_colors = function(colors) return { fg = colors.fg_dark } end,
  },
  config = function(_, opts)
    vim.opt.cursorline = true -- Highlight line at the cursor position
    vim.o.background = "dark" -- Default to dark theme


    --require("monokai-nightasty").load(opts)
  end,
}
