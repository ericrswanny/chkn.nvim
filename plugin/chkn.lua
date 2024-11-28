vim.api.nvim_create_user_command("ChknToggle", function()
	require("chkn.scratchpad").open()
end, { desc = "Toggle Chkn" })
