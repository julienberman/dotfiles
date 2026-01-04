-- Autoformat
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		-- Disable format_on_save for languages without a well-defined standardized coding style
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end
		end,
		-- Formatters. Can run multiple formatters sequentially.
		formatters_by_ft = {
			lua = { "stylua" },
			-- python = { "isort", "black" },
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
	},
}
