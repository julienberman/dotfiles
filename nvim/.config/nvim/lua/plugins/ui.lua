-- ui: Navigation, diagnostics, display, notifications, etc

return {
	-- ════════════════════════════════════════════════════════════════════════════
	-- mini.icons -> Icons
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"nvim-mini/mini.icons",
		version = false,
		opts = {},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- noice -> Use floating windows and popups for search, the command line, etc.
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<C-k>",
				function()
					require("noice.lsp").signature()
				end,
				mode = "i",
				desc = "Show signature help",
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
		opts = {
			views = {
				hover = {
					border = {
						padding = { 0, 1 },
						style = "rounded",
					},
					size = {
						height = "auto",
						width = "auto",
						max_height = 20,
						max_width = 40,
					},
				},
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
				split = {
					position = "bottom",
					size = "50%",
					enter = true,
					win_options = {
						wrap = true,
					},
				},
			},
			lsp = {
				hover = { view = "split" },
				signature = {
					auto_open = {
						enabled = false,
					},
					view = "hover",
				},
			},
			routes = {
				{
					filter = {
						event = "lsp",
						kind = "progress",
					},
					opts = { skip = true },
				},
			},
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- mini.statusline -> Custom statusline at the bottom of editor
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"nvim-mini/mini.statusline",
		version = false,
		dependencies = {
			"nvim-mini/mini.icons",
		},
		opts = {
			content = {
				active = function()
					local trunc_width = 140
					local is_truncated = MiniStatusline.is_truncated(trunc_width)
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = trunc_width })
					local search = MiniStatusline.section_searchcount({ trunc_width = trunc_width })

					local path = vim.fn.expand("%:p")
					local filename = vim.fn.expand("%:t")
					local root = vim.fs.root(0, ".git")
					if path == "" then
						path = "[No Name]"
					elseif root then
						path = path:sub(#root + 2)
					else
						path = vim.fn.fnamemodify(path, ":~:.")
					end

					if is_truncated then
						path = vim.fn.pathshorten(path)
					end

					local modified = vim.bo.modified and "●" or ""
					local reg = vim.fn.reg_recording()
					local recording = reg ~= "" and ("Recording macro to register " .. reg) or ""
					local location = is_truncated and "%l/%L" or "Line %l of %L"

					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode:lower() } },
						"%<",
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						{ hl = "MiniStatuslineModified", strings = { modified } },
						{ hl = "MiniStatuslineRecording", strings = { recording } },
						"%=",
						{ hl = "MiniStatuslinePath", strings = { path } },
						{ hl = mode_hl, strings = { search, location } },
					})
				end,
				inactive = function()
					return MiniStatusline.active()
				end,
			},
			use_icons = true,
		},
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
		opts = {
			-- ════════════════════════════════════════════════════════════════════════════
			-- dashboard -> Custom startup screen.
			-- ════════════════════════════════════════════════════════════════════════════
			dashboard = {
				enabled = true,
				preset = {
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
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- render-markdown -> Render markdown in buffer while in normal mode
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
		    enabled = false,
        },
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
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
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
			keywords = {
				TODO = { color = "todo" },
				FIX = { color = "fix" },
				BUG = { color = "fix" },
				HACK = { color = "hack" },
				NOTE = { color = "note" },
			},
			colors = {
				todo = { "TodoCommentTodo" },
				fix = { "TodoCommentFix" },
				hack = { "TodoCommentHack" },
				note = { "TodoCommentNote" },
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
	-- nvim-herdr-navigator -> Use vim bindings to navigate between neovim and herdr
	-- ════════════════════════════════════════════════════════════════════════════
    {
        "kaar/nvim-herdr-navigator",
        lazy = false,
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
			vim.g.slime_dont_ask_default = 1
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
	-- ════════════════════════════════════════════════════════════════════════════
	-- arrow -> Buffer management
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"otavioschwanck/arrow.nvim",
		dependencies = {
			"echasnovski/mini.icons",
		},
		opts = {
			show_icons = true,
			leader_key = ";",
			buffer_leader_key = "m",
			mappings = {
				edit = "i",
				delete_mode = "d",
				clear_all_items = "C",
				toggle = "s",
				open_vertical = "v",
				open_horizontal = "h",
				quit = "q",
				remove = "x",
				next_item = "]",
				prev_item = "[",
			},
		},
	},
}
