-- Color scheme. Change by updating name of plugin, then change command in the config to the name of that colorscheme.
-- See :Telescope colorscheme to see which colorschemes are already installed
return {
	"folke/tokyonight.nvim",
	-- must load before other plugins
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("tokyonight").setup({
			styles = {
				comments = { italic = false },
			},
		})

		-- Load colorscheme
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
