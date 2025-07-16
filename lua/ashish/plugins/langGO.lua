return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- This is where the go.nvim setup goes

    require("go").setup()

    -- --- Run gofmt + goimports on save ---
    -- This code should be inside the config function
    local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
    vim.api.nvim_create_autocmd("BufWritePre", {

      pattern = "*.go",
      callback = function()
        require('go.format').goimports()
      end,
      group = format_sync_grp,
    })
  end,

  -- event = { "CmdlineEnter" }, -- This might be too late for some setups, Consider removing if you use `lazy = false` or have other loading triggers.
  ft = { "go", 'gomod' },

  -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}

