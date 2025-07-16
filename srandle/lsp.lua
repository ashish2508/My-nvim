-- /home/ash/.config/nvim/lua/srandle/lsp.lua

local expand_keymaps = require("utils.expand").expand_keymaps
local lsp_utils = require("utils.lsp") -- Renamed to avoid conflict with lspconfig
local SERVERS = require("constants.pulled").SERVERS
local lspconfig = require("lspconfig") -- You need to require lspconfig

local capabilities = lsp_utils.create_capabilities() -- Assuming create_capabilities is in utils.lsp

-- Loop through your servers and set them up using lspconfig
for _, server_name in ipairs(SERVERS) do
  lspconfig[server_name].setup({
    capabilities = capabilities,
    -- Add other server-specific configurations here if needed
    -- settings = { ... },
  })
end

vim.cmd([[hi FloatShadow guifg=white guibg=#1f2335]])
vim.cmd([[hi FloatShadowThrough guifg=white guibg=#1f2335]])

require("ufo").setup() -- Assuming you have the ufo plugin

lsp_utils.setup_borders() -- Assuming setup_borders is in utils.lsp

expand_keymaps({ -- Corrected expand_kemaps to expand_keymaps
	n = {
		["K"] = { vim.lsp.buf.hover, "LSP Hover" }, -- Use vim.lsp.buf.hover
		["gd"] = { vim.lsp.buf.definition, "Go to definition" },
		["<leader>fc"] = { vim.lsp.buf.format, "Format code" },
		["[d"] = { lsp_utils.jump("prev"), "Go to previous diagnostic" }, -- Assuming jump is in utils.lsp
		["]d"] = { lsp_utils.jump("next"), "Go to next diagnostic" }, -- Assuming jump is in utils.lsp
	},
})

-- You might also want to add autocommands for attaching to LSP buffers
vim.api.nvim_create_autocmd('LspAttach', {
group = vim.api.nvim_create_augroup('UserLspConfig', {}),
callback = function(ev)
vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
end,
})

