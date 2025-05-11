vim.cmd("let g:netrw_liststyle=3")

local opt = vim.opt
opt.incsearch = true
opt.rnu = true
opt.nu = true
vim.opt.shell = "/bin/bash"
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.showmode = false
opt.wrap = false
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.cursorline = true
opt.backup = false
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

opt.updatetime = 50
opt.timeoutlen = 200

vim.cmd([[highlight YankHighlight guibg=#e04340]])
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})
