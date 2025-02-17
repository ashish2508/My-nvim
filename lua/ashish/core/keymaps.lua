local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--local themes = require("ashish.plugins.themes")
vim.g.mapleader = " "

keymap.set("i", "jj", "<ESC>==", opts)

keymap.set({ "n", "v" }, "yx", ":%y+<CR>==", opts)
keymap.set({ "n", "v" }, "dx", ":%d+<CR>==", opts)
keymap.set("n", "<M-Down>", ":m .+1<CR>==", opts)
keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv", opts)

keymap.set("n", "<M-Up>", ":m .-2<CR>==", opts)
keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv", opts)

-- Open fold under cursor
vim.keymap.set("n", "fo", function()
  vim.cmd("normal! zO")
end, { desc = "Open fold under cursor" })

-- Close fold under cursor
vim.keymap.set("n", "fc", function()
  vim.cmd("normal! zC")
end, { desc = "Close fold under cursor" })

keymap.set("n", "<C-M-Down>", ":t .<CR>", opts)
keymap.set("v", "<C-M-Down>", ":t .<CR>", opts)

keymap.set("n", "<C-M-Up>", ":t .<CR> .-2<CR>", opts)
keymap.set("n", "<C-M-Up>", ":t .<CR> '<-2<CR>gv", opts)

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

keymap.set("n", "dw", 'vb"_d')
keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set("n", "<C-n>", ":tabedit<CR>", opts)
keymap.set("n", "<C-]>", ":tabnext<CR>", opts)
keymap.set("n", "<C-l>", ":tabprev<CR>", opts)

-- Split windoW
keymap.set("n", "<leader>ss", ":split<Return>", opts)
keymap.set("n", "<leader>sv", ":vsplit<Return>", opts)
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

keymap.set({ "n", "i", "v" }, "<C-q>", "<ESC>:wq<CR>", opts)

vim.g.have_nerd_font = true

keymap.set({ "n", "i" }, "<C-s>", "<ESC>:w<CR>", opts)
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })

keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
keymap.set("n", "<leader>.e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror message" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list " })

vim.api.nvim_set_keymap("n", "<M-1>", "<cmd>ToggleTerm<CR>", opts)
vim.api.nvim_set_keymap("t", "<M-1>", "<cmd>ToggleTerm<CR>", opts)

--Blocking Arrow KEYS
keymap.set({ "n", "v" }, "<Left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set({ "n", "v" }, "<Right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set({ "n", "v" }, "<Up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set({ "n", "v" }, "<Down>", '<cmd>echo "Use j to move!!"<CR>')

-- Example key mappings
vim.keymap.set("n", "fo", function()
  vim.cmd("normal! zO") -- Open fold under cursor
end, { desc = "Open fold under cursor" })

vim.keymap.set("n", "fc", function()
  vim.cmd("normal! zC") -- Close fold under cursor
end, { desc = "Close fold under cursor" })

keymap.set("n", "<leader>asr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })             -- restore last workspace session for current directory
keymap.set("n", "<leader>ass", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

--To rename a word in a single file

vim.keymap.set('n', '<leader>raf', function()
  local old_name = vim.fn.input("Old variable name: ")
  local new_name = vim.fn.input("New variable name: ")
  vim.api.nvim_command('%s/\\<' .. old_name .. '\\>/' .. new_name .. '/g')
end, { noremap = true, silent = true, desc = "Rename variable in current file" })

--To rename the word in whole folder

vim.keymap.set('n', '<leader>rap', function()
  local old_name = vim.fn.input("Old variable name: ")
  local new_name = vim.fn.input("New variable name: ")
  local files = vim.fn.systemlist('grep -rl "\\<' .. old_name .. '\\>" .')
  for _, file in ipairs(files) do
    vim.api.nvim_command('edit ' .. file)
    vim.api.nvim_command('%s/\\<' .. old_name .. '\\>/' .. new_name .. '/g')
    vim.api.nvim_command('write')
  end
end, { noremap = true, silent = true, desc = "Rename variable in whole project" })
