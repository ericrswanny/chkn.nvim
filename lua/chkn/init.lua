local M = {}

function M.setup(user_config)
	print("chkn.nvim setup called")
	require("chkn.scratchpad").setup(user_config)
end

return M
