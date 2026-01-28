-- Edit and compile TeX documents

return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- pin version
	-- tag = "v2.15",
	init = function()
		vim.g.vimtex_view_method = "skim"
		-- vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
	end,
}
