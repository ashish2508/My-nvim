return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = "never"
      else
        lsp_format_opt = "fallback"
      end
      return {
        timeout_ms = 1000,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      -- Lua
      lua = { "stylua" },

      -- Go
      go = {
        "gofumpt",
        "goimports",
        -- "golines",
      },

      -- C/C++
      cpp = { "clang-format" },
      c = { "clang-format" },

      -- JavaScript/TypeScript
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },

      -- Web Technologies
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      sass = { "prettier" },
      less = { "prettier" },

      -- Python
      python = { "black", "isort" },

      -- Java
      java = { "google-java-format" },

      -- Rust
      rust = { "rustfmt" },

      -- PHP
      php = { "php_cs_fixer" },

      -- Ruby
      ruby = { "rubocop" },

      -- Data formats
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      yml = { "prettier" },
      toml = { "taplo" },
      xml = { "xmlformat" },

      -- Shell scripting
      bash = { "shfmt" },
      sh = { "shfmt" },
      zsh = { "shfmt" },

      -- Docker
      dockerfile = { "hadolint" },

      -- SQL
      sql = { "sqlfluff" },

      -- Markdown
      markdown = { "prettier" },

      -- Configuration files
      nginx = { "nginxfmt" },

      -- Other languages
      swift = { "swift_format" },
      kotlin = { "ktlint" },
      dart = { "dart_format" },

      -- Terraform
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },

      -- GraphQL
      graphql = { "prettier" },

      -- Vue
      vue = { "prettier" },

      -- Svelte
      svelte = { "prettier" },

      -- Elixir
      elixir = { "mix" },

      -- Nix
      nix = { "nixfmt" },
    },
  },
}
