local M = {}

function M.setup(user_config)
	require("chkn.scratchpad").setup(user_config)
end

-- Register the ChknToggle command globally
vim.api.nvim_create_user_command("ChknToggle", function(args)
	require("chkn.scratchpad").open(args.args)
end, { nargs = "?", desc = "Toggle Chkn" })

return M
