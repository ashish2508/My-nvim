return {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('monokai-pro').setup({
      transparent_background = false,
      terminal_colors = false,
      devicons = true,
      styles = {
        comment = { italic = true },
        keyword = { italic = false },
        type = { italic = false },
        storageclass = { italic = false },
        structure = { italic = false },
        parameter = { italic = false },
        annotation = { italic = true },
        tag_attribute = { italic = true },
      },
      filter = 'octagon', -- octagon | pro | machine
      day_night = {
        enable = false,
        day_filter = 'pro',
        night_filter = 'spectrum',
      },
      inc_search = 'background',
      background_clear = {
        'toggleterm',
        'telescope',
        'renamer',
        'notify',
        'nvim-tree',
      },
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
        },
        indent_blankline = {
          context_highlight = 'pro',
          context_start_underline = false,
        },
      },
      override = function(c) end,
    })
    --vim.cmd('colorscheme monokai-pro')

  end,
}

