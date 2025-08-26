return {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000,
  opts = {
    background = "hard", -- "soft", "medium", "hard"
    transparent_background_level = 100, -- 0 to 100
    dim_inactive_windows = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      functions = "bold",
      strings = "NONE",
      variables = "NONE",
    },
  },
  config = function(_, opts)
    require("everforest").setup(opts)
    vim.cmd("colorscheme everforest")
  end,
}
