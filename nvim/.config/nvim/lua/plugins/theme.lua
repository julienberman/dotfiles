-- theme: Set neovim color scheme

return {
	"catppuccin/nvim",
	priority = 1000,
	opts = {
		flavour = "mocha",
		styles = {
			comments = {},
		},
		auto_integrations = true,
		custom_highlights = function(colors)
			return {
				NoiceCmdlineIcon = { fg = colors.mauve },
				NoiceCmdlinePopupBorder = { fg = colors.mauve },
				MiniStatuslineModeInsert = { fg = colors.base, bg = colors.green, bold = true },
				MiniStatuslineFilename = { fg = colors.text, bg = colors.surface0 },
				MiniStatuslinePath = { fg = colors.text, bg = colors.surface0 },
				MiniStatuslineModified = { fg = colors.lavender, bg = colors.surface0, bold = true },
				MiniStatuslineRecording = { fg = colors.red, bg = colors.surface0, bold = true },
				SnacksDashboardNormal = { fg = colors.lavender, bg = colors.base },
				SnacksDashboardHeader = { fg = colors.lavender, bg = colors.base },
				SnacksDashboardFooter = { fg = colors.lavender, bg = colors.base },
				SnacksDashboardIcon = { fg = colors.lavender, bg = colors.base },
				SnacksDashboardDesc = { fg = colors.lavender, bg = colors.base },
				SnacksDashboardKey = { fg = colors.lavender, bg = colors.base },
				SnacksDashboardDir = { fg = colors.lavender, bg = colors.base },
				SnacksDashboardFile = { fg = colors.lavender, bg = colors.base },
                TodoCommentTodo = { fg = colors.lavender },
                TodoCommentFix = { fg = colors.red },
                TodoCommentHack = { fg = colors.flamingo },
                TodoCommentNote = { fg = colors.mauve },
			}
		end,
	},
	config = function(_, opts)
		local catppuccin = require("catppuccin")
		catppuccin.setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
