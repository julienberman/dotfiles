-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter",
	-- Configuration. See :help nvim-treesitter.
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"css",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"r",
			"regex",
			"vim",
			"vimdoc",
		},
		-- Ignore TeX documents
		ignore_install = { "latex" },
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			disable = { "latex" },
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	},
}
