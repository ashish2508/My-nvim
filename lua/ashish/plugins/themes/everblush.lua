return {
  'Everblush/nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('everblush').setup({
      transparent_background = false,
      nvim_tree = {
        contrast = false,
      },
    })
    --vim.cmd('colorscheme everblush')
  end
}
