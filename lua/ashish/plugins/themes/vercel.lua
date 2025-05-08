return {
  -- Vercel theme
  {
    "tiesen243/vercel.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("vercel-dark")

      require('vercel').setup({
        transparent = true,
        italics = {
          comments = false,
          keywords = false,
          functions = false,
          strings = false,
          variables = false,
        },
        bold = {
          comments = false,
          keywords = true,
          functions = true,
          strings = false,
          variables = true,

        },
        overrides = {},
      })
    end,

  },

  -- Transparent nvim
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup()
      -- Clear prefixes after setup
      require("transparent").clear_prefix("NeoTree")
      require("transparent").clear_prefix("lualine_c")

      require("transparent").clear_prefix("lualine_x_diff")
      require("transparent").clear_prefix("lualine_transitional_lualine_b")
    end,
  },
}
