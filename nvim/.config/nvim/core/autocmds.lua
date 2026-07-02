local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight text on yank",
	callback = function()
		vim.hl.on_yank()
	end,
})
