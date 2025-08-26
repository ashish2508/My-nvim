-- client.notify -> client:notify
local mt = getmetatable(vim.lsp.client)
if mt and mt.__index and mt.__index.notify == nil and mt.__index.rpc and mt.__index.rpc.notify then
  mt.__index.notify = function(self, method, params)
    return self.rpc.notify(method, params)
  end
end

-- vim.highlight.on_yank -> vim.hl.on_yank
if vim.highlight and vim.hl and vim.highlight.on_yank and vim.hl.on_yank then
  vim.highlight.on_yank = vim.hl.on_yank
end

-- vim.validate (fallback to old impl if missing)
if vim._validate and not vim.validate then
  vim.validate = vim._validate
end

if vim.loader then
  vim.loader.enable()
end
vim.opt.clipboard = "unnamedplus"

require("ashish")
require("floaterminal")
