return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path",   -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",     -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim",         -- vs-code like pictograms
    { 
      "samiulsami/cmp-go-deep", 
      dependencies = { "kkharji/sqlite.lua" } 
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    require("luasnip.loaders.from_vscode").lazy_load()
    
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<up>"] = cmp.mapping.select_prev_item(),   -- previous suggestion
        ["<down>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-up>"] = cmp.mapping.scroll_docs(4),
        ["<C-down>"] = cmp.mapping.scroll_docs(-4),
        ["<C-a>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<CR>"] = cmp.mapping.abort(),     -- close completion window
        ["<Tab>"] = cmp.mapping.confirm({ select = false }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" },  -- text within current buffer
        { name = "path" },    -- file system paths
        {
          name = "go_deep",
          keyword_length = 3,
          max_item_count = 5,
          ---@module "cmp_go_deep"
          ---@type cmp_go_deep.Options
          option = {
            -- Add your cmp-go-deep configuration options here
            -- For example:
            -- db_path = "~/.cache/nvim/cmp_go_deep.db",
            -- max_results = 10,
            -- min_keyword_length = 2,
          },
        },
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
