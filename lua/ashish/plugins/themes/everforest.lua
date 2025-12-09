return {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000,
  opts = {
    background = "hard", -- "soft", "medium", "hard"
    transparent_background_level = 0, -- 0 to 1
    dim_inactive_windows = false,
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
    --vim.cmd("colorscheme everforest")
  end,
}
