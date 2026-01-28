------ SECTION: GLOBALS ------

-- Set <space> as the leader key. Must occur before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

------ SECTION: OPTIONS ------

-- Add line numbers and relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Don't show the mode (already in the status line)
vim.o.showmode = false

-- Sync clipboard between OS and Neovim. Schedule after `UiEnter`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true
vim.opt.autoindent = true
vim.cmd("filetype plugin indent on")

-- Save undo history
vim.o.undofile = true

-- Set default shiftwidth and tab sizing, expand tabs to spaces
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.expandtab = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Add confirmation on action that would fail due to unsaved changes in buffer
vim.o.confirm = true

-- Set highlights on search
vim.opt.hlsearch = true

------ SECTION: KEYMAPS -----

-- Clear highlights on search when press esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Set `jj` to be equivalent to `esc`
vim.keymap.set("i", "jj", "<Esc>")

-- Make page down and page up automatically center cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up, center cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down, center cursor" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Remap bind to exit the neovim terminal mode (may not work with all terminal emulators)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds for split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Keybinds for R
vim.keymap.set("i", "<A-->", "<- ", { desc = "Shortcut for assignment arrow" })
vim.keymap.set("i", "<A-S-m>", " %>% ", { desc = "Shortcut for pipe arrow" })

------ SECTION: AUTOCOMMANDS ------

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

------ SECTION: INSTALL LAZY.NVIM -----

-- Set path for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is installed. If not, clone repo
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

-- add lazy.nvim to runtime path
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

------ SECTION: PLUGINS -----

-- Plugins are located in /lua/plugins
-- Check the current status of plugins with :Lazy
-- Sync reality to config with :Lazy sync

-- Setup all plugins
-- require("lazy").setup("plugins")

-- Manually set up plugins
require("lazy").setup({
	require("plugins.autopairs"),
	require("plugins.blink-cmp"),
	require("plugins.conform"),
	require("plugins.gitsigns"),
	require("plugins.guess-indent"),
	require("plugins.harpoon"),
	require("plugins.lazydev"),
	require("plugins.mini"),
	-- require("plugins.neo-tree"),
	require("plugins.neoscroll"),
	require("plugins.nvim-lspconfig"),
	require("plugins.telescope"),
	require("plugins.theme"),
	require("plugins.todo-comments"),
	require("plugins.treesitter"),
	require("plugins.vim-slime"),
	require("plugins.vim-python-pep8-indent"),
	require("plugins.vim-tmux-navigator"),
	require("plugins.vimtex"),
	require("plugins.which-key"),
	require("plugins.yazi"),
}, {
	-- Icons for Lazy ui
	ui = {
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- Modeline. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
