-- Color scheme. Change by updating name of plugin, then change command in the config to the name of that colorscheme.
-- See :Telescope colorscheme to see which colorschemes are already installed
return {
	"catppuccin/nvim",
	-- must load before other plugins
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			styles = {
				comments = {},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
