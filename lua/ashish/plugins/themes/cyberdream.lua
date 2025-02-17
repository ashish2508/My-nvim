return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = false,

      -- Enable italics comments
      italic_comments = false,

      -- Replace all fillchars with ' ' for the ultimate clean look
      hide_fillchars = true,

      -- Modern borderless telescope theme - also applies to fzf-lua
      borderless_pickers = false,

      -- Set terminal colors used in `:terminal`
      terminal_colors = false,
    })
    vim.api.nvim_set_keymap("n", "<leader>ccd", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })
    vim.cmd("colorscheme cyberdream")
  end
}
