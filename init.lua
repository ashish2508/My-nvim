if vim.loader then
  vim.loader.enable()
end
vim.opt.clipboard = "unnamedplus"
vim.print = _G.dd
require("ashish")
require("floaterminal")
