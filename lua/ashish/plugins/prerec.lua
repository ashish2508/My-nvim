return {
  "tris203/precognition.nvim",
  event = "BufRead",
  keys = {
    {
      "<leader>pre",
      function()
        require("precognition").toggle()
      end,
      desc = "precognition",
    },
  },
}
