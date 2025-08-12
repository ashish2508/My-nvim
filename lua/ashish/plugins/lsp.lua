return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "mason-org/mason.nvim", version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    { "jay-babu/mason-null-ls.nvim" },
    { "nvimtools/none-ls.nvim" },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "jcha0713/cmp-tw2css",
    "hrsh7th/nvim-cmp",
    "b0o/schemastore.nvim", -- Added for JSON schema support
  },

  config = function()
    vim.diagnostic.config({
      float = { border = "rounded" },
    })

    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities =
      vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = false,
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "tinymist",
        "html",
        "ts_ls",
        "gopls",
        "dockerls",
        "clangd", -- For C/C++
        "jdtls", -- For Java
        "prismals", -- For Prisma
        "jsonls", -- For JSON (dedicated server)
        "tailwindcss", -- For Tailwind CSS
        "elixirls", -- For Elixir
        "csharp_ls", -- For C#
      },
    })

    -- Setup mason-null-ls for formatters
    require("mason-null-ls").setup({
      ensure_installed = {
        -- C/C++
        "clang_format",
        -- Java
        "google_java_format",
        -- JavaScript/TypeScript/JSX/TSX
        "prettier",
        "eslint_d",
        -- JSON
        "jq",
        -- Lua
        "stylua",
        -- Docker
        "dockerfilelint",
        -- Rust
        "rustfmt",
        -- Go
        "gofmt",
        "goimports",
        -- Elixir
        "mix",
        -- HTML
        "htmlbeautifier",
        -- C#
        "csharpier",
      },
      automatic_installation = false,
      handlers = {},
    })

    -- Setup null-ls (none-ls) for formatters
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- C/C++
        null_ls.builtins.formatting.clang_format.with({
          filetypes = { "c", "cpp", "objc", "objcpp" },
          extra_args = { "--style=Google" }, -- You can customize this
        }),

        -- Java
        null_ls.builtins.formatting.google_java_format,

        -- JavaScript/TypeScript/JSX/TSX/JSON
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            "yaml",
            "markdown",
          },
        }),
        null_ls.builtins.diagnostics.eslint_d.with({
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        }),

        -- Lua
        null_ls.builtins.formatting.stylua,

        -- Rust (handled by rust-analyzer LSP, but adding as backup)
        null_ls.builtins.formatting.rustfmt,

        -- Go
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,

        -- Elixir
        null_ls.builtins.formatting.mix,

        -- HTML
        null_ls.builtins.formatting.htmlbeautifier,

        -- C#
        null_ls.builtins.formatting.csharpier,
      },
    })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["svelte"] = function()
          require("lspconfig")["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  -- this bad boy updates imports between svelte and ts/js files
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,
        ["tinymist"] = function()
          require("lspconfig")["tinymist"].setup({
            capabilities = capabilities,
            settings = {
              formatterMode = "typstyle",
              exportPdf = "never",
            },
          })
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
        end,
        ["html"] = function()
          require("lspconfig")["html"].setup({
            capabilities = capabilities,
            filetypes = { "html", "htm" },
            settings = {
              html = {
                format = {
                  templating = true,
                  wrapLineLength = 120,
                  wrapAttributes = "auto",
                },
                hover = {
                  documentation = true,
                  references = true,
                },
              },
            },
          })
        end,
        ["ts_ls"] = function()
          require("lspconfig")["ts_ls"].setup({
            capabilities = capabilities,
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "json",
            },
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "literal",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = false,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          })
        end,
        ["gopls"] = function()
          require("lspconfig")["gopls"].setup({
            capabilities = capabilities,
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
                usePlaceholders = true,
                completeUnimported = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
              },
            },
          })
        end,
        ["dockerls"] = function()
          require("lspconfig")["dockerls"].setup({
            capabilities = capabilities,
            settings = {
              docker = {
                languageserver = {
                  formatter = {
                    ignoreMultilineInstructions = true,
                  },
                },
              },
            },
          })
        end,
        ["clangd"] = function()
          require("lspconfig")["clangd"].setup({
            capabilities = capabilities,
            cmd = { "clangd", "--background-index" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
          })
        end,
        ["jdtls"] = function()
          require("lspconfig")["jdtls"].setup({
            capabilities = capabilities,
            filetypes = { "java" },
          })
        end,
        ["prismals"] = function()
          require("lspconfig")["prismals"].setup({
            capabilities = capabilities,
            filetypes = { "prisma" },
          })
        end,
        ["jsonls"] = function()
          require("lspconfig")["jsonls"].setup({
            capabilities = capabilities,
            filetypes = { "json", "jsonc" },
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          })
        end,
        ["tailwindcss"] = function()
          require("lspconfig")["tailwindcss"].setup({
            capabilities = capabilities,
            filetypes = {
              "css",
              "scss",
              "sass",
              "html",
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "svelte",
              "vue",
            },
            init_options = {
              userLanguages = {
                eelixir = "html-eex",
                eruby = "erb",
              },
            },
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  },
                },
              },
            },
          })
        end,
        ["elixirls"] = function()
          require("lspconfig")["elixirls"].setup({
            capabilities = capabilities,
            filetypes = { "elixir", "eex", "heex", "surface" },
            settings = {
              elixirLS = {
                dialyzerEnabled = false,
                fetchDeps = false,
              },
            },
          })
        end,
        ["csharp_ls"] = function()
          require("lspconfig")["csharp_ls"].setup({
            capabilities = capabilities,
            filetypes = { "cs" },
          })
        end,
      },
    })

    local l = vim.lsp
    l.handlers["textDocument/hover"] = function(_, result, ctx, config)
      config = config or { border = "rounded", focusable = true }
      config.focus_id = ctx.method
      if not (result and result.contents) then
        return
      end
      local markdown_lines = l.util.convert_input_to_markdown_lines(result.contents)
      markdown_lines = vim.tbl_filter(function(line)
        return line ~= ""
      end, markdown_lines)
      if vim.tbl_isempty(markdown_lines) then
        return
      end
      return l.util.open_floating_preview(markdown_lines, "markdown", config)
    end

    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    vim.api.nvim_set_hl(0, "CmpNormal", {})
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = vim.NIL,
      }),

      window = {
        completion = {
          scrollbar = false,
          border = "rounded",
          winhighlight = "Normal:CmpNormal",
        },
        documentation = {
          scrollbar = false,
          border = "rounded",
          winhighlight = "Normal:CmpNormal",
        },
      },
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
          end,
        },
        { name = "cmp-tw2css" },
      }, {}),
    })

    local autocmd = vim.api.nvim_create_autocmd

    autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.vert", "*.frag" },
      callback = function(e)
        vim.cmd("set filetype=glsl")
      end,
    })

    -- Additional filetype associations for better LSP support
    autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.jsx", "*.tsx" },
      callback = function(e)
        if vim.fn.expand("%:e") == "jsx" then
          vim.cmd("set filetype=javascriptreact")
        elseif vim.fn.expand("%:e") == "tsx" then
          vim.cmd("set filetype=typescriptreact")
        end
      end,
    })

    autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "Dockerfile*", "*.dockerfile" },
      callback = function(e)
        vim.cmd("set filetype=dockerfile")
      end,
    })

    -- Additional autocmds for new filetypes
    autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.prisma" },
      callback = function(e)
        vim.cmd("set filetype=prisma")
      end,
    })

    -- C# filetype
    autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.cs" },
      callback = function(e)
        vim.cmd("set filetype=cs")
      end,
    })

    -- Elixir filetypes
    autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.ex", "*.exs", "*.eex", "*.heex", "*.surface" },
      callback = function(e)
        local ext = vim.fn.expand("%:e")
        if ext == "ex" or ext == "exs" then
          vim.cmd("set filetype=elixir")
        elseif ext == "eex" then
          vim.cmd("set filetype=eex")
        elseif ext == "heex" then
          vim.cmd("set filetype=heex")
        elseif ext == "surface" then
          vim.cmd("set filetype=surface")
        end
      end,
    })

    autocmd("LspAttach", {
      callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
        vim.keymap.set("n", "<leader>la", function()
          vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>lr", function()
          vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("n", "<leader>k", function()
          vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "<leader>ln", function()
          vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "<leader>lp", function()
          vim.diagnostic.goto_prev()
        end, opts)

        -- Enhanced format on save for multiple languages
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = e.buf,
          callback = function()
            local filetype = vim.bo.filetype
            local format_filetypes = {
              "c",
              "cpp",
              "java",
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "json",
              "jsonc",
              "lua",
              "rust",
              "go",
              "elixir",
              "html",
              "cs",
            }

            if vim.tbl_contains(format_filetypes, filetype) then
              vim.lsp.buf.format({ async = false })
            end
          end,
        })
      end,
    })
  end,
}
