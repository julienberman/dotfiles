-- lsp: Configure LSPs and LSP management

local formatters = { "stylua", "gofumpt", "ruff" }
local linters = { "mypy" }
local language_servers = {
	"lua_ls",
	"pyright",
}

local all_mason_packages = vim.iter({ language_servers, linters, formatters }):flatten():totable()

return {
	{
		"whoissethdaniel/mason-tool-installer.nvim",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
		},
		opts = {
			ensure_installed = all_mason_packages,
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{
				"neovim/nvim-lspconfig",
			},
		},
		opts = {},
	},
	{
		"saghen/blink.cmp",
		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = { documentation = { auto_show = true, auto_show_delay_ms = 300 } },
			sources = {
				default = { "lsp", "path", "snippets" },
			},
			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},
		},
	},
}
