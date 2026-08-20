local api = vim.api

-- Alias to open Diffview on yank
api.nvim_create_user_command("Diff", function(opts)
    vim.api.nvim_cmd({ cmd = "DiffviewOpen", args = opts.fargs }, {})
end, { nargs = "*" })

-- Alias to close tab
api.nvim_create_user_command("Q", "tabclose", {})
