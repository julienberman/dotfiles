-- ui: Navigation, diagnostics, display, notifications, etc (with the exception of the statusline, which is a part of mini.nvim)

return {
	-- ════════════════════════════════════════════════════════════════════════════
	-- noice -> Use floating windows and popups for search, the command line, etc.
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
		opts = {
			views = {
				popup = {
					position = {
						row = "65%",
						col = "50%",
					},
				},
				cmdline_popup = {
					position = {
						row = "65%",
						col = "50%",
					},
				},
			},
		},
		config = function(_, opts)
			local noice = require("noice")
			local palette = require("catppuccin.palettes").get_palette("mocha")
			noice.setup(opts)
		end,
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- neoscroll -> Add scroll animation on <C-u> and <C-d>
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"karb94/neoscroll.nvim",
		opts = {
			post_hook = function(info)
				vim.cmd("normal! zz")
			end,
		},
		config = function(_, opts)
			local neoscroll = require("neoscroll")
			neoscroll.setup(opts)
			local keymap = {
				["<C-u>"] = function()
					neoscroll.ctrl_u({
						duration = 100,
					})
				end,
				["<C-d>"] = function()
					neoscroll.ctrl_d({
						duration = 100,
					})
				end,
				["<C-b>"] = function()
					neoscroll.ctrl_b({ duration = 450 })
				end,
				["<C-f>"] = function()
					neoscroll.ctrl_f({ duration = 450 })
				end,
				["<C-y>"] = function()
					neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
				end,
				["<C-e>"] = function()
					neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
				end,
				["zt"] = function()
					neoscroll.zt({ half_win_duration = 250 })
				end,
				["zz"] = function()
					neoscroll.zz({ half_win_duration = 250 })
				end,
				["zb"] = function()
					neoscroll.zb({ half_win_duration = 250 })
				end,
			}
			local modes = { "n", "v", "x" }
			for key, func in pairs(keymap) do
				vim.keymap.set(modes, key, func)
			end
		end,
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- snacks.nvim -> Add dashboard on start, add ability to open images.
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = false },

			-- ════════════════════════════════════════════════════════════════════════════
			-- dashboard -> Custom startup screen.
			-- ════════════════════════════════════════════════════════════════════════════
			dashboard = {
				enabled = true,
				config = function()
					local palette = require("catppuccin.palettes").get_palette("mocha")
					local lavender = palette.lavender
					local bg = palette.base

					local function set(name)
						vim.api.nvim_set_hl(0, name, { fg = lavender, bg = bg })
					end

					set("SnacksDashboardNormal")
					set("SnacksDashboardHeader")
					set("SnacksDashboardFooter")
					set("SnacksDashboardIcon")
					set("SnacksDashboardDesc")
					set("SnacksDashboardKey")
					set("SnacksDashboardDir")
					set("SnacksDashboardFile")
				end,
				preset = {
					-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
					---@type fun(cmd:string, opts:table)|nil
					pick = nil,
					-- Used by the `keys` section to show keymaps.
					-- Set your custom keymaps here.
					-- When using a function, the `items` argument are the default keymaps.
					---@type snacks.dashboard.Item[]
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = "<leader>sf",
						},
						{
							icon = " ",
							key = "n",
							desc = "New File",
							action = ":ene | startinsert",
						},
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = "<leader>sg",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = "<leader>sr",
						},
						{
							icon = " ",
							key = "c",
							desc = "Neovim config",
							action = "<leader>sn",
						},
						{
							icon = " ",
							key = "s",
							desc = "Restore session",
							section = "session",
						},
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
			explorer = { enabled = false },
			-- ════════════════════════════════════════════════════════════════════════════
			-- image -> open images in editor
			-- ════════════════════════════════════════════════════════════════════════════
			image = {
				enabled = true,
				doc = {
					enabled = true,
					inline = true,
					float = true,
					max_width = 80,
					max_height = 40,
				},
			},
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = false },
			notifier = { enabled = false },
			quickfile = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- render-markdown -> Render markdown in buffer while in normal mode
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- vim-python-pep8-indent -> Modify indentation to conform to PEP8 style
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"Vimjas/vim-python-pep8-indent",
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- which-key -> Keybinding help
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"folke/which-key.nvim",
		-- Set loading event
		event = "VimEnter",
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			delay = 0,
			icons = {
				-- handle icon keys and mappings depending on whether have nerd font
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
			},
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- indent-blankline -> Draw vertical lines for each indent
	-- ════════════════════════════════════════════════════════════════════════════
	{
		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			opts = {},
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- todo-comments -> Highlight todo, notes, etc in comments
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- conform -> Automatic code formatting
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			-- Disable format_on_save for languages without a well-defined standardized coding style
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			-- Formatters. Can run multiple formatters sequentially.
			formatters_by_ft = {
				lua = { "stylua" },
				-- python = { "isort", "black" },
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- vim-tmux-navigator -> Use vim bindings to navigate between neovim and tmux
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- vim-slime -> Send code from neovim to live REPL
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"jpalardy/vim-slime",
		init = function()
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
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- yazi -> File tree in neovim
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"mikavilpas/yazi.nvim",
		-- Latest stable version
		version = "*",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		-- Keybinds
		keys = {
			{
				-- Open in current file
				"<leader>y",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
		},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
			highlight_hovered_buffers_in_same_directory = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- mark netrw as loaded so it's not loaded at all.
			--
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			vim.g.loaded_netrwPlugin = 1
		end,
	},
}
