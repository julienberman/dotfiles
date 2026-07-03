-- Set <space> as the leader key. Must occur before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

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
vim.opt.tabstop = 4
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

-- Hide command line below status line
vim.opt.cmdheight = 0
