-- formatting: Configuration for code formatting

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					conform = require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix", "ruff_organize_imports", "ruff_format" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
