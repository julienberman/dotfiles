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

		local function mode_segment()
			local mode = vim.fn.mode()
			local is_insert = mode:sub(1, 1) == "i"
			local mode_text = is_insert and "insert" or "normal"
			local mode_hl = is_insert and "MiniStatuslineModeInsert" or "MiniStatuslineModeNormal"
			local mode_display = " " .. mode_text .. " "
			local segment = statusline.combine_groups({
				{ hl = mode_hl, strings = { mode_display } },
			})
			return segment, mode_display
		end

		local function truncate_right(text, max_width)
			if max_width <= 0 then
				return ""
			end
			if vim.fn.strdisplaywidth(text) <= max_width then
				return text
			end
			return vim.fn.strcharpart(text, 0, max_width)
		end

		local function statusline_content()
			local width = vim.api.nvim_win_get_width(0)
			local filepath = relative_path_for_display(vim.fn.expand("%:p"))
			local show_location_gap = width >= 100
			local show_location = width >= 90
			local show_git = width >= 90
			local use_short_path = not show_location and width < 80
			if use_short_path then
				filepath = vim.fn.pathshorten(filepath)
			end
			local mode_part, mode_display = mode_segment()
			local modified = vim.bo.modified
			local modified_text = modified and (" " .. icons.dot .. " ") or ""
			local modified_part = modified
					and statusline.combine_groups({
						{ hl = "MiniStatuslineModified", strings = { modified_text } },
					})
				or ""
			local git = show_git and statusline.section_git({ trunc_width = 40 }) or ""
			local git_text = git ~= "" and (" " .. git .. " ") or ""
			local git_part = git ~= ""
					and statusline.combine_groups({
						{ hl = "MiniStatuslineGit", strings = { git_text } },
					})
				or ""
			local location_numbers = tostring(vim.fn.line(".")) .. "/" .. tostring(vim.fn.line("$"))
			local location_text = show_location and ((show_location_gap and " " or "") .. "%l/%L ") or ""
			local location_visible = show_location and ((show_location_gap and " " or "") .. location_numbers .. " ")
				or ""
			local location_part = location_text ~= ""
					and statusline.combine_groups({
						{ hl = "MiniStatuslineLocation", strings = { location_text } },
					})
				or ""
			local right_width = vim.fn.strdisplaywidth(git_text) + vim.fn.strdisplaywidth(location_visible)
			local left_fixed_width = vim.fn.strdisplaywidth(mode_display) + vim.fn.strdisplaywidth(modified_text)
			local max_path_width = width - left_fixed_width - right_width
			local path_text = truncate_right(" " .. filepath .. " ", max_path_width)
			local path_part = path_text ~= ""
					and statusline.combine_groups({
						{ hl = "MiniStatuslinePath", strings = { path_text } },
					})
				or ""
			local left = statusline.combine_groups({
				{ strings = { mode_part } },
				{ strings = { path_part } },
				{ strings = { modified_part } },
			})
			local right = statusline.combine_groups({
				{ strings = { git_part } },
				{ strings = { location_part } },
			})
			return statusline.combine_groups({
				{ strings = { left } },
				{ strings = { "%=" } },
				{ strings = { right } },
			})
		end

		statusline.setup({
			use_icons = use_icons,
			content = {
				active = statusline_content,
				inactive = statusline_content,
			},
		})
	end,
}
