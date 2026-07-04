-- picker: Search and select files, buffers, and everything else

return {
	-- ════════════════════════════════════════════════════════════════════════════
	-- telescope -> Picker
	-- ════════════════════════════════════════════════════════════════════════════
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-mini/mini.icons",
	},
	opts = {
		defaults = {
			preview = {
				hide_on_startup = true,
				treesitter = true,
			},
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
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
			file_ignore_patterns = { "%.git/." },
			path_display = function(opts, path)
				local utils = require("telescope.utils")
				local path_trunc_len = 25
				local filename_len = 32
				local path = vim.fn.fnamemodify(utils.path_expand(path), ":p")
				local filename = utils.path_tail(path)
				local root = vim.fs.root(0, ".git")

				if path == "" then
					path = "[No Name]"
				elseif root then
					path = path:sub(#root + 2)
				else
					path = vim.fn.fnamemodify(path, ":~:.")
				end

				if #path >= path_trunc_len then
					path = vim.fn.pathshorten(path, 2)
				end

				local path_string =
					string.format("%-" .. filename_len .. "." .. filename_len .. "s  %s", filename, path)
				-- local highlights = {
				-- 	{
				-- 		{
				-- 			#path,
				-- 		},
				-- 		"Comment",
				-- 	},
				-- }
				return path_string
			end,
			layout_strategy = "vertical",
			layout_config = {
				vertical = {
					width = function(_, max_columns, _)
						return math.min(max_columns, 90)
					end,
					height = function(_, _, max_lines)
						return math.min(max_lines, 20)
					end,
					prompt_position = "top",
					preview_cutoff = 1,
					preview_height = 0.4,
				},
				horizontal = {
					width = function(_, max_columns, _)
						return math.min(max_columns, 120)
					end,
					height = function(_, _, max_lines)
						return math.min(max_lines, 25)
					end,
					preview_cutoff = 120,
					prompt_position = "top",
					preview_width = function(_, max_columns, _)
						-- return 0.5 * math.min(max_columns, 100) / 3
						return 80
					end,
				},
			},
			border = true,
		},
		pickers = {
			find_files = {
				prompt_title = "Find file...",
				follow = true,
				hidden = true,
			},
			buffers = {
				prompt_title = "Find open buffer...",
				mappings = {
					n = {
						["d"] = "delete_buffer",
					},
				},
				initial_mode = "normal",
			},
			current_buffer_fuzzy_find = {
				prompt_title = "Fuzzy search current buffer...",
				previewer = true,
				layout_strategy = "horizontal",
			},
			live_grep = {
				prompt_title = "Find string in files...",
				previewer = true,
				only_sort_text = true,
				layout_strategy = "horizontal",
			},
			grep_string = {
				previewer = true,
				only_sort_text = true,
				layout_strategy = "horizontal",
			},
			keymaps = {},
			diagnostics = {},
			oldfiles = {},
			help_tags = {
				previewer = true,
				layout_strategy = "horizontal",
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					previewer = false,
					initial_mode = "normal",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
				}),
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup(opts)

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch for current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "[S]earch [R]ecent Files" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set(
			"n",
			"<leader>/",
			builtin.current_buffer_fuzzy_find,
			{ desc = "[/] Fuzzy search current buffer" }
		)
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
			})
		end, { desc = "[S]earch [/] in Open Files" })
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "[S]earch [N]eovim config files" })
		vim.keymap.set("n", "<leader>so", function()
			builtin.find_files({
				cwd = vim.fn.expand("~/.config/opencode"),
			})
		end, { desc = "[S]earch [O]pencode config files" })
		vim.keymap.set("n", "<leader>st", function()
			builtin.find_files({
				cwd = vim.fn.expand("~/.config/tmux"),
			})
		end, { desc = "[S]earch [T]mux config files" })
	end,
}
