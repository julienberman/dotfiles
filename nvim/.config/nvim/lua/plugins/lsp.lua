-- lsp: Configure LSPs and LSP management

return {
	-- ════════════════════════════════════════════════════════════════════════════
	-- mason -> manage LSP servers, linters, and formatters
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- mason-tool-installer -> ensure that language servers and other tools are installed
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"whoissethdaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				-- language servers (must be Mason package names)
				"lua-language-server",
				-- "ruby-lsp",
				"pyright",
				-- formatters
				"stylua",
				"ruff",
				-- linters
				"mypy",
			},
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- nvim-lspconfig -> maintain default config files for each lsp. Override settings in `lsp/`.
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"neovim/nvim-lspconfig",
		opts = {},
		config = function()
			vim.lsp.enable({
				"lua_ls",
				"pyright",
				"ruby_lsp",
			})
		end,
	},
}
