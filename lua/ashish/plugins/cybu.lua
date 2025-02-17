return {
  "ghillb/cybu.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  config = function()
    require("cybu").setup({
      behavior = {
        mode = {
          default = {
            switch = "immediate",
            view = "rolling",
          },
          last_used = {
            switch = "on_close",
            view = "paging",
          },
          auto = {
            view = "rolling",
          },
        },
        show_on_autocmd = false,
      },
      display_time = 550,
    })
  end,
  keys = {
    {
      "<tab>",
      function()
        require("cybu").cycle("next")
      end,
      mode = { "n", "v" },
      desc = "cybu - next",
    },
    {
      "<s-tab>",
      function()
        require("cybu").cycle("prev")
      end,
      mode = { "n", "v" },
      desc = "cybu - prev",
    },
  },
  event = "BufRead",
}
