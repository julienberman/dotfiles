-- lazy: Install lazy.nvim and install plugins

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is installed. If not, clone repo
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

-- add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- install plugins. Toggle a given plugin by adding "enabled = false" to its config.
require("lazy").setup({ import = "plugins" })
