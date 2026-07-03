-- editor: text editing

return {
	-- ════════════════════════════════════════════════════════════════════════════
	-- mini.ai -> enhance "around" and "in" text objects
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"nvim-mini/mini.ai",
		version = false,
		opts = {
			n_lines = 500,
			custom_textobjects = {
				-- Define `vaf` and `vif` -> around / in "function"
				f = spec_treesitter({
					a = "@function.outer",
					i = "@function.inner",
				}),
				-- Define `vae` and `vie` -> around / in "expression"
				e = spec_treesitter({
					a = {
						"@function.outer",
						"@conditional.outer",
						"@loop.outer",
					},
					i = {
						"@function.inner",
						"@conditional.inner",
						"@loop.inner",
					},
				}),
			},
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- mini.surround -> add, delete, and replace surrounding characters
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"nvim-mini/mini.surround",
		version = false,
		opts = {},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- mini.comment -> toggle comments
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"nvim-mini/mini.comment",
		version = false,
		opts = {},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- treesitter ->
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			indent = { enable = false },
		},
		config = function(_, opts)
			local treesitter = require("nvim-treesitter")
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
			treesitter.install(languages)
			treesitter.setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- treesitter-textobjects ->
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		opts = {
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
				},
				include_surrounding_whitespace = false,
			},
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- treesj -> Easily expand and contract iterables across multiple lines
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- guess-indent -> Estimate indent width of file and update shiftwidth etc. accordingly.
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"NMAC427/guess-indent.nvim",
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- autopairs -> Automatically pair closing brackets..
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
}
