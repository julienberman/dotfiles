-- Collection of various small independent plugins / modules

return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({
			n_lines = 500,
			custom_textobjects = {
				f = require("mini.ai").gen_spec.treesitter({
					a = "@function.outer",
					i = "@function.inner",
				}),
			},
		})

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		require("mini.surround").setup()

		-- Statusline (could remove and try other plugins)
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2L"
		end
	end,
}
