-- pyright: Override settings for pyright imported from nvim-lspconfig

local function get_python_path(root_dir)
	local path = root_dir .. "/.venv/bin/python"
	if vim.fn.executable(path) == 1 then
		return path
	end

	return vim.fn.exepath("python3") or "python"
end

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "requirements.txt", ".git" },
	before_init = function(_, config)
		local python_path = get_python_path(config.root_dir or vim.fn.getcwd())

		config.settings = config.settings or {}
		config.settings.python = config.settings.python or {}
		config.settings.python.pythonPath = python_path
	end,
}
