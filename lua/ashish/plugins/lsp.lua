return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "mason-org/mason.nvim", version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "jcha0713/cmp-tw2css",
    "hrsh7th/nvim-cmp",
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
      },
      handlers = {
        function(server_name)
          vim.lsp.config(server_name, {
            capabilities = capabilities,
          })
        end,
        ["svelte"] = function()
          vim.lsp.config("svelte", {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  -- this bad boy updates imports between svelte and ts/js files
                  client.notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_bufnr(ctx.buf) })
                end,
              })
            end,
          })
        end,
        ["tinymist"] = function()
          vim.lsp.config("tinymist", {
            capabilities = capabilities,
            settings = {
              formatterMode = "typstyle",
              exportPdf = "never",
            },
          })
        end,
        ["lua_ls"] = function()
          vim.lsp.config("lua_ls", {
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
          vim.lsp.config("html", {
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
          vim.lsp.config("ts_ls", {
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
          vim.lsp.config("gopls", {
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
          vim.lsp.config("dockerls", {
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
      end,
    })
  end,
}
