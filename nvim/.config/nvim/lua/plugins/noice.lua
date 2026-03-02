return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local noice = require("noice")
		local palette = require("catppuccin.palettes").get_palette("mocha")
		noice.setup({
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
		})
		vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = palette.mauve })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = palette.mauve })
	end,
}
