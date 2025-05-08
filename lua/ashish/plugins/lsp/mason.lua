return {
  "williamboman/mason.nvim",

  lazy = true,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
  },

  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "gopls",
        "emmet_language_server",
        "eslint",
        "marksman",
        "clangd",
        "denols",
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "pylint",
        { "eslint_d", version = "13.1.2" },
      },
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["emmet_language_server"] = function()
        lspconfig.emmet_language_server.setup({
          capabilities = capabilities,
          filetypes = {
            "css",
            "eruby",
            "html",
            "javascript",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "pug",
            "typescriptreact",
            "vue",
            "svelte",
            "astro",
          },
          init_options = {
            includeLanguages = {},
            excludeLanguages = {},
            extensionsPath = {},
            preferences = {},
            showAbbreviationSuggestions = true,
            showExpandedAbbreviation = "always",
            showSuggestionsAsSnippets = false,
            syntaxProfiles = {},
            variables = {},
          },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
              inlayHint = {
                enable = true,
              },
            },
          },
        })
      end,
      ["denols"] = function()
        lspconfig.denols.setup({
          capabilities = capabilities,
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
          init_options = {},
        })
      end,
      ["ts_ls"] = function()
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
          root_dir = function(fname)
            local util = lspconfig.util
            return not util.root_pattern("deno.json", "deno.jsonc")(fname)
              and util.root_pattern("tsconfig.json")(fname)
          end,
          single_file_support = false,
          init_options = {
            preferences = {
              includeCompletionsWithSnippetText = true,
              includeCompletionsForImportStatements = true,
            },
          },
        })
      end,
      ["eslint"] = function()
        lspconfig.eslint.setup({
          capabilities = capabilities,
          settings = {
            eslint = {
              workingDirectories = nil,
            },
          },
        })
      end,
      ["clangd"] = function()
        lspconfig.clangd.setup({
          capabilities = capabilities,
          flags = {},
        })
      end,
    })
  end,
}

