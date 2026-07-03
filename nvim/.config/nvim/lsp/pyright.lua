-- pyright: Override settings for pyright imported from nvim-lspconfig

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "requirements.txt", ".git" },
}
