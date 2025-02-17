return {
  'Everblush/nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('everblush').setup({
      transparent_background = false,
      nvim_tree = {
        contrast = true, -- Resolved conflict: set contrast to true
      },
    })
    --vim.cmd('colorscheme everblush')
  end
}
