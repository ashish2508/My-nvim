if vim.loader then
  vim.loader.enable()
end
vim.env.VIMRUNTIME = "/opt/nvim/share/nvim/runtime"
vim.print = _G.dd
require("ashish")
require("floaterminal")
