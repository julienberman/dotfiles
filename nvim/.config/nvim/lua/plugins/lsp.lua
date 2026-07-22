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
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "[G]o to [d]efinition" })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "[G]et [r]eferences" })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show documentation" })
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "[R]ename symbol" })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "[C]ode [a]ctions" })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "[G]o to [i]mplementation" })
		end,
	},
}
