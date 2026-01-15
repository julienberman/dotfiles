-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		require("plugins.textobjects"),
	},
	config = function()
		local ts = require("nvim-treesitter")
		local languages = {
			"bash",
			"c",
			"rust",
			"css",
			"diff",
			"html",
			"latex",
			"lua",
			"markdown",
			"python",
			"query",
			"r",
			"regex",
			"vim",
		}
		ts.install(languages)
		ts.setup({
			indent = { enable = false },
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
