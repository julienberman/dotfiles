local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight text on yank",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Fix shiftwidth for ruby files
api.nvim_create_autocmd("FileType", {
    pattern = "ruby",
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.tabstop = 2
    end,
})

-- Help window height
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.api.nvim_win_set_height(0, math.floor(vim.o.lines / 2))
    end,
})

-- Remove continue comment on newline
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "r", "o" })
    end,
})
