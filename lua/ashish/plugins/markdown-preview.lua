return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  keys = {
    {
      "<leader>md",
      "<cmd>MarkdownPreviewToggle<CR>",
      desc = "Markdown Preview",
      cond = function()
        return vim.bo.filetype == "markdown"
      end,
    },
  },
  config = function()
    vim.cmd([[do FileType]])
  end,
}
