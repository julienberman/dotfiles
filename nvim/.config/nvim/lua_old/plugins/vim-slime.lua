return {
	"jpalardy/vim-slime",
	config = function()
		-- Use tmux as the target
		vim.g.slime_target = "tmux"
		vim.g.slime_default_config = {
			socket_name = "default",
			target_pane = "{right-of}", -- sends to pane on the right
		}
		vim.g.slime_dont_ask_default = 0
		vim.g.slime_preserve_curpos = 1
		vim.g.slime_python_ipython = 1
		-- vim.g.slime_bracketed_paste = 1
		-- Keybindings
		vim.keymap.set("n", "<C-c>l", "<Plug>SlimeLineSend", { desc = "Send line to REPL" })
		vim.keymap.set("n", "<C-c><C-c>", "<Plug>SlimeParagraphSend", { desc = "Send paragraph to REPL" })
		vim.keymap.set("x", "<C-c><C-c>", "<Plug>SlimeRegionSend", { desc = "Send selection to REPL" })
		vim.keymap.set("n", "<C-c>v", "<Plug>SlimeConfig", { desc = "Configure slime target" })
	end,
}
