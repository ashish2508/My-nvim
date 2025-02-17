return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "typescript-language-server" },
        typescript = { "typescript-language-server" },
        css = { "ast-grep" },
        cpp = { "astyle" },
        c = { "astyle" },
        java = { "google-java-format" },
        GoLang = { "djlint" },
        html = { "ast-grep" },
        json = { "jsonlint" },
        yaml = { "actionlint" },
        markdown = { "harper-ls" },
        graphql = { "graphql-language-service-cli" },
        liquid = { "prettier" },
        python = { "isort", "black" },
        zig = { "zigfmt" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<C-a><C-h>", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
