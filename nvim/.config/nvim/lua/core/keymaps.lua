-- Set <space> as the leader key. Must occur before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear highlights on search when press esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Make page down and page up automatically center cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up, center cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down, center cursor" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Remap bind to exit the neovim terminal mode (may not work with all terminal emulators)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds for split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Keybinds for buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Open next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Open previous buffer" })

-- Keybinds for R
vim.keymap.set("i", "<A-->", "<- ", { desc = "Shortcut for assignment arrow" })
vim.keymap.set("i", "<A->>", "%>% ", { desc = "Shortcut for pipe arrow" })
