return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"html",
				"css",
				"scss",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				emmet_language_server = {},
				html = {},
				cssmodules_ls = {},
				css_variables = {},
				cssls = {
					lint = {
						compatibleVendorPrefixes = "ignore",
						vendorPrefix = "ignore",
						unknownVendorSpecificProperties = "ignore",

						-- unknownProperties = "ignore", -- duplicate with stylelint

						duplicateProperties = "warning",
						emptyRules = "warning",
						importStatement = "warning",
						zeroUnits = "warning",
						fontFaceProperties = "warning",
						hexColorLength = "warning",
						argumentsInColorFunction = "warning",
						unknownAtRules = "warning",
						ieHack = "warning",
						propertyIgnoredDueToDisplay = "warning",
					},
				},
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"emmet-language-server",
				"html-lsp",
				"cssmodules-language-server",
				"css-variables-language-server",
				"css-lsp",
				"htmlhint",
				"stylelint",
			},
		},
	},

	{
		"luckasRanarison/nvim-devdocs",
		optional = true,
		opts = {
			ensure_installed = {
				"html",
				"css",
				"sass",
			},
		},
	},
}
