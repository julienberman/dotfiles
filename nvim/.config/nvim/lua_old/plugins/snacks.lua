return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = false },

		-- startup screen
		dashboard = {
			enabled = true,
			config = function()
				local palette = require("catppuccin.palettes").get_palette("mocha")
				local lavender = palette.lavender
				local bg = palette.base

				local function set(name)
					vim.api.nvim_set_hl(0, name, { fg = lavender, bg = bg })
				end

				set("SnacksDashboardNormal")
				set("SnacksDashboardHeader")
				set("SnacksDashboardFooter")
				set("SnacksDashboardIcon")
				set("SnacksDashboardDesc")
				set("SnacksDashboardKey")
				set("SnacksDashboardDir")
				set("SnacksDashboardFile")
			end,
			preset = {
				-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
				---@type fun(cmd:string, opts:table)|nil
				pick = nil,
				-- Used by the `keys` section to show keymaps.
				-- Set your custom keymaps here.
				-- When using a function, the `items` argument are the default keymaps.
				---@type snacks.dashboard.Item[]
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = "<leader>sf",
					},
					{
						icon = " ",
						key = "n",
						desc = "New File",
						action = ":ene | startinsert",
					},
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = "<leader>sg",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = "<leader>sr",
					},
					{
						icon = " ",
						key = "c",
						desc = "Neovim config",
						action = "<leader>sn",
					},
					{
						icon = " ",
						key = "s",
						desc = "Restore session",
						section = "session",
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		explorer = { enabled = false },
		image = {
			enabled = true,
			doc = {
				enabled = true,
				inline = true,
				float = true,
				max_width = 80,
				max_height = 40,
			},
		},
		indent = { enabled = false },
		input = { enabled = false },
		picker = { enabled = false },
		notifier = { enabled = false },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
}
