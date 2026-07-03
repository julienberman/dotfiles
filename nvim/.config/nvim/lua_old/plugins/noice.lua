return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		views = {
			popup = {
				position = {
					row = "65%",
					col = "50%",
				},
			},
			cmdline_popup = {
				position = {
					row = "65%",
					col = "50%",
				},
			},
		},
	},
	config = function(_, opts)
		local noice = require("noice")
		local palette = require("catppuccin.palettes").get_palette("mocha")
		noice.setup(opts)
		vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = palette.mauve })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = palette.mauve })
	end,
}
