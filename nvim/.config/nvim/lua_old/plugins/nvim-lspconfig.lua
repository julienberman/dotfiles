-- Language Server Protocol (LSF) config. Helps editors and language tooling communicate. Gives Neovim autocomplete, etc.
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- install LSPs and related tools to stdpath
		{
			"mason-org/mason.nvim",
			opts = {},
		},
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{
			"j-hui/fidget.nvim",
			opts = {},
		},

		-- Allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	config = function()
		-- Runs every time a new file is opened that is associated with an LSP (e.g. main.rs associated with Rust). Will configure current buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			-- Helper function to define mappings specific to LSP-related items.
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Rename the variable under your cursor.
				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action (if cursor on top of error)
				map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

				-- Find references for word under your cursor.
				map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the definition of the word under your cursor.
				map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				--  Jump to the declaration of the word under your cursor
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Fuzzy find all the symbols in your current document.
				map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

				-- Fuzzy find all the symbols in your current workspace.
				map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

				-- Jump to the type of the word under your cursor.
				map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

				-- Resolve difference between neovim nightly (0.11) stable (0.10)
				---@param client vim.lsp.Client
				---@param method vim.lsp.protocol.Method
				---@param bufnr? integer
				---@return boolean
				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end

				-- highlight references of the word under cursor. Clear on move.
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client_supports_method(
						client,
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- keymap to toggle inlay hints (if language supports)
				if
					client
					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
				then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Diagnostic Config
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		--  Add capabilities to Neovim, then broadcast to servers
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Enable the following language servers. Will autoinstall.
		-- Add override configs (cmd, filetypes, capabilities, settings)
		-- See :help lspconfig-all for a list of pre-configured LSPs
		local servers = {
			-- clangd = {},
			-- gopls = {},
			-- pyright = {},
			-- rust_analyzer = {},
			-- ... etc.

			lua_ls = {
				-- cmd = { ... },
				-- filetypes = { ... },
				-- capabilities = { ... },
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
		}

		-- Ensure the servers and tools above are installed with :Mason
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- handles overriding only values explicitly passed by the server configuration above
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
