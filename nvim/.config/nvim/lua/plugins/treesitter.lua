-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
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

		require("nvim-treesitter").install(languages)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
