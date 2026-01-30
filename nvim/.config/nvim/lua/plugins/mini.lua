-- Collection of various small independent plugins / modules

return {
	"echasnovski/mini.nvim",
	config = function()
		-- Icons
		local mini_icons = require("mini.icons")
		mini_icons.setup({ style = "glyph" })

		-- Enhance "around" and "in" textobjects
		local ai = require("mini.ai")
		ai.setup({
			n_lines = 500,
			custom_textobjects = {
				f = ai.gen_spec.treesitter({
					a = "@function.outer",
					i = "@function.inner",
				}),
			},
		})

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		-- local surround = require("mini.surround").setup()

		-- Command line
		-- local cmdline = require("mini.cmdline")
		-- cmdline.setup()

		-- Recover previous sessions
		local sessions = require("mini.sessions")
		sessions.setup()

		-- Status line
		local statusline = require("mini.statusline")
		local palette = require("catppuccin.palettes").get_palette("mocha")

		vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = palette.base, bg = palette.lavender, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = palette.base, bg = palette.green, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslinePath", { fg = palette.text, bg = palette.surface0 })
		vim.api.nvim_set_hl(0, "MiniStatuslineModified", { fg = palette.lavender, bg = palette.surface0, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineGit", { fg = palette.text, bg = palette.surface0 })
		vim.api.nvim_set_hl(0, "MiniStatuslineLocation", { fg = palette.text, bg = palette.surface0 })

		local use_icons = vim.g.have_nerd_font
		local icons = {
			dot = use_icons and "●" or "*",
		}

		local function git_root_for_path(path)
			local dir = path ~= "" and vim.fn.fnamemodify(path, ":h") or vim.fn.getcwd()
			local output = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
			if vim.v.shell_error ~= 0 or #output == 0 then
				return nil
			end
			return output[1]
		end

		local function relative_path_for_display(path)
			if path == "" then
				return "[No Name]"
			end
			local home = vim.fn.expand("~")
			local root = git_root_for_path(path)
			if not root then
				root = path:sub(1, #home) == home and home or "/"
			end
			local rel = path:sub(1, #root) == root and path:sub(#root + 1) or path
			if rel:sub(1, 1) == "/" then
				rel = rel:sub(2)
			end
			return rel ~= "" and rel or vim.fn.fnamemodify(path, ":t")
		end

		local function mode_indicator()
			local mode = vim.fn.mode()
			local is_insert = mode:sub(1, 1) == "i"
			local mode_text = is_insert and "insert" or "normal"
			local mode_hl = is_insert and "MiniStatuslineModeInsert" or "MiniStatuslineModeNormal"
			return statusline.combine_groups({
				{ hl = mode_hl, strings = { " " .. mode_text .. " " } },
			})
		end

		statusline.setup({
			use_icons = use_icons,
			content = {
				active = function()
					local width = vim.api.nvim_win_get_width(0)
					local filepath = relative_path_for_display(vim.fn.expand("%:p"))
					if width < 80 then
						filepath = vim.fn.pathshorten(filepath)
					end
					local modified = vim.bo.modified
							and statusline.combine_groups({
								{ hl = "MiniStatuslineModified", strings = { " " .. icons.dot .. " " } },
							})
						or ""
					local git = width < 90 and "" or statusline.section_git({ trunc_width = 40 })
					local git_segment = git ~= ""
							and statusline.combine_groups({
								{ hl = "MiniStatuslineGit", strings = { " " .. git .. " " } },
							})
						or ""
					local path_segment = statusline.combine_groups({
						{ hl = "MiniStatuslinePath", strings = { " " .. filepath .. " " } },
					})
					local location_segment = width < 90 and ""
						or statusline.combine_groups({
							{ hl = "MiniStatuslineLocation", strings = { " %2l/%-2L " } },
						})
					local left = statusline.combine_groups({
						{ strings = { mode_indicator(), " " } },
						{ strings = { path_segment } },
						{ strings = { modified } },
					})
					local right = statusline.combine_groups({
						{ strings = { git_segment } },
						{ strings = { location_segment } },
					})
					return statusline.combine_groups({
						{ strings = { left } },
						{ strings = { "%=" } },
						{ strings = { right } },
					})
				end,
				inactive = function()
					local width = vim.api.nvim_win_get_width(0)
					local filepath = relative_path_for_display(vim.fn.expand("%:p"))
					if width < 80 then
						filepath = vim.fn.pathshorten(filepath)
					end
					local modified = vim.bo.modified
							and statusline.combine_groups({
								{ hl = "MiniStatuslineModified", strings = { " " .. icons.dot .. " " } },
							})
						or ""
					local git = width < 90 and "" or statusline.section_git({ trunc_width = 40 })
					local git_segment = git ~= ""
							and statusline.combine_groups({
								{ hl = "MiniStatuslineGit", strings = { " " .. git .. " " } },
							})
						or ""
					local path_segment = statusline.combine_groups({
						{ hl = "MiniStatuslinePath", strings = { " " .. filepath .. " " } },
					})
					local location_segment = width < 90 and ""
						or statusline.combine_groups({
							{ hl = "MiniStatuslineLocation", strings = { " %2l/%-2L " } },
						})
					local left = statusline.combine_groups({
						{ strings = { mode_indicator(), " " } },
						{ strings = { path_segment } },
						{ strings = { modified } },
					})
					local right = statusline.combine_groups({
						{ strings = { git_segment } },
						{ strings = { location_segment } },
					})
					return statusline.combine_groups({
						{ strings = { left } },
						{ strings = { "%=" } },
						{ strings = { right } },
					})
				end,
			},
		})
	end,
}
