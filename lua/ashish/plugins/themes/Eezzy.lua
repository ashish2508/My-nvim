return { 
  'ashish2508/Eezzy.nvim',  -- GitHub repository path
  lazy = false,
  priority = 1000,
  config = function()
    local ok, eezzy = pcall(require, 'Eezzy')
    
    if ok and eezzy and type(eezzy.setup) == "function" then
      eezzy.setup({
        transparent = false,
        italics = {
          comments = false,
          keywords = true,
          functions = true,
          strings = false,
          variables = true,
        },
        overrides = {},
      })
    else
      print("Failed to load eezzy module or setup function")
    end
    
    --vim.cmd.colorscheme("Eezzy-dark")
  end
}
