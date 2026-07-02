-- theme: Set neovim color scheme

return {
	"catppuccin/nvim",
	-- must load before other plugins
	priority = 1000,
	opts = {
		flavour = "mocha",
		styles = {
			comments = {},
		},
		auto_integrations = true,
		custom_highlights = function(colors)
			return {
				NoiceCmdlineIcone = { fg = colors.mauve },
				NoiceCmdlinePopupBorder = { fg = colors.mauve },
			}
		end,
	},
	config = function(_, opts)
		local catppuccin = require("catppuccin")
		catppuccin.setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
