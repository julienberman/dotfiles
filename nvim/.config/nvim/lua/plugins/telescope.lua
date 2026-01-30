-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` on install
			build = "make",

			-- `cond` that must be satified to kick off installation
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- get pretty icons if have nerd font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	-- :Telescope help_tags for info. ? means normal mode; <c-/> means insert
	config = function()
		-- Configuration for mappings / updates. See :help telescope.setup()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "TelescopeResults",
			callback = function(ctx)
				vim.api.nvim_buf_call(ctx.buf, function()
					vim.fn.matchadd("TelescopeParent", "\t\t.*$")
					vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
				end)
			end,
		})

		-- Get git root (cached)
		local cached_git_root = nil
		local function get_git_root()
			if cached_git_root == nil then
				local result = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 then
					cached_git_root = false
				else
					cached_git_root = result
				end
			end
			return cached_git_root or nil
		end

		local function formattedName(_, path)
			local git_root = get_git_root()

			local relative_path = path
			if git_root and path:sub(1, #git_root) == git_root then
				relative_path = path:sub(#git_root + 2)
			end

			local tail = vim.fs.basename(path)
			local dir = vim.fs.dirname(relative_path)

			if dir == "." then
				return tail
			end

			return string.format("%s\t\t%s", tail, dir) -- tabs
		end

		telescope.setup({
			file_ignore_patterns = { "%.git/." },
			defaults = {
				previewer = false,
				initial_mode = "insert",
				select_strategy = "reset",
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
					preview_cutoff = 120,
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				},
			},
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			pickers = {
				find_files = {
					previewer = false,
					path_display = formattedName,
					layout_config = {
						height = 0.4,
						prompt_position = "top",
						preview_cutoff = 120,
					},
				},
				git_files = {
					previewer = false,
					path_display = formattedName,
					layout_config = {
						height = 0.4,
						prompt_position = "top",
						preview_cutoff = 120,
					},
				},
				buffers = {
					path_display = formattedName,
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
						n = {
							["d"] = actions.delete_buffer,
						},
					},
					previewer = false,
					initial_mode = "normal",
					-- theme = "dropdown",
					layout_config = {
						height = 0.4,
						width = 0.6,
						prompt_position = "top",
						preview_cutoff = 120,
					},
				},
				current_buffer_fuzzy_find = {
					previewer = true,
					layout_config = {
						prompt_position = "top",
						preview_cutoff = 120,
					},
				},
				live_grep = {
					only_sort_text = true,
					previewer = true,
				},
				grep_string = {
					only_sort_text = true,
					previewer = true,
				},
				lsp_references = {
					show_line = false,
					previewer = true,
				},
				treesitter = {
					show_line = false,
					previewer = true,
				},
				colorscheme = {
					enable_preview = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						previewer = false,
						initial_mode = "normal",
						sorting_strategy = "ascending",
						layout_strategy = "horizontal",
						layout_config = {
							horizontal = {
								width = 0.5,
								height = 0.4,
								preview_width = 0.6,
							},
						},
					}),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })

		vim.keymap.set("n", "<leader>sf", function()
			builtin.find_files({
				hidden = true,
			})
		end, { desc = "[S]earch [F]iles" })

		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "[S]earch [R]ecent Files" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- Change theme
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Additional keymaps
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
				hidden = true,
			})
		end, { desc = "[S]earch [N]eovim files" })

		-- Shortcut for searching opencode configuration files
		vim.keymap.set("n", "<leader>so", function()
			builtin.find_files({
				cwd = vim.fn.expand("~/.config/opencode"),
				hidden = true,
				follow = true,
			})
		end, { desc = "[S]earch [O]pencode files" })
	end,
}
