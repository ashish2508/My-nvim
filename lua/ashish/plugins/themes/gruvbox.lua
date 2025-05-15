return {
  {
    "ricardoraposo/gruvbox-minor.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      
      
      -- Make it transparent
      vim.api.nvim_command("highlight Normal guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight NormalNC guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight NormalFloat guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight SignColumn guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight LineNr guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight CursorLineNr guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight EndOfBuffer guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight FloatBorder guibg=NONE ctermbg=NONE")
      
      -- Make statusline and lualine transparent
      vim.api.nvim_command("highlight StatusLine guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight StatusLineNC guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight StatusLineTerm guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight StatusLineTermNC guibg=NONE ctermbg=NONE")
      
    
      -- Make tabline transparent as well
      vim.api.nvim_command("highlight TabLine guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight TabLineFill guibg=NONE ctermbg=NONE")
      vim.api.nvim_command("highlight TabLineSel guibg=NONE ctermbg=NONE")
      
      -- Fix colors for inactive statusline sections (if needed)
      vim.api.nvim_command("highlight link lualine_a_inactive lualine_a_normal")
      vim.api.nvim_command("highlight link lualine_b_inactive lualine_b_normal")
      vim.api.nvim_command("highlight link lualine_c_inactive lualine_c_normal")


      -- Set the colorscheme
      -- vim.cmd([[colorscheme gruvbox-minor]]) -- for oh-lucy

    end
  }
}
