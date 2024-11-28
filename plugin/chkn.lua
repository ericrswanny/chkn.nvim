vim.api.nvim_create_user_command("ChknToggle", function()
	print("ChknToggle command is being loaded")
	require("chkn.scratchpad").open()
end, { desc = "Toggle Chkn" })
