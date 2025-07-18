---@type vim.lsp.Config
local M = {}

-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
M.init_options = { html = { options = { ["bem.enabled"] = true } } }

M.filetypes = require("constants.ft").EMMET_FILETYPES

M.settings = {}

return M
