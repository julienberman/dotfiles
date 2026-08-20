-- git: All git related plugins

return {
	-- ════════════════════════════════════════════════════════════════════════════
	-- neogit -> git interface for neovim
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			-- diff view
			"sindrets/diffview.nvim",
			-- Custom log pager
			"m00qek/baleia.nvim",
			-- Picker
			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		opts = {
			kind = "floating",
			integrations = {
				diffview = true,
				telescope = false,
			},
			commit_editor = {
				kind = "floating",
				show_staged_diff = false,
				staged_diff_split_kind = "split",
				spell_check = true,
			},
			commit_select_view = {
				kind = "tab",
			},
			commit_view = {
				kind = "floating",
				verify_commit = vim.fn.executable("gpg") == 1,
			},
			log_view = {
				kind = "floating",
			},
			rebase_editor = {
				kind = "auto",
			},
			reflog_view = {
				kind = "tab",
			},
			merge_editor = {
				kind = "auto",
			},
			preview_buffer = {
				kind = "floating_console",
			},
			popup = {
				kind = "tab",
				show_title = false,
			},
			stash = {
				kind = "floating",
			},
			refs_view = {
				kind = "tab",
			},
			signs = {
				section = { "", "" },
				item = { "", "" },
				hunk = { "", "" },
			},
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Show diff view between current and head" },
			{ "<leader>gD", "<cmd>DiffviewOpen main<cr>", desc = "Show diff view between current and main" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
			{ "<leader>gl", "<cmd>Neogit log<cr>", desc = "Show git log" },
		},
	},
	-- ════════════════════════════════════════════════════════════════════════════
	-- diffview -> easily compare working tree to index
	-- ════════════════════════════════════════════════════════════════════════════
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
		},
		opts = {
			file_panel = {
				listing_style = "tree",
				win_config = {
					position = "left",
				},
			},
		},
	},
}
