describe("ChknToggle command", function()
	it("should register the ChknToggle command", function()
		-- Check if the command exists
		local commands = vim.api.nvim_get_commands({})
		assert.is_not_nil(commands["ChknToggle"])
	end)

	it("should open and close the scratchpad via the command", function()
		vim.cmd("ChknToggle") -- Open the scratchpad
		local scratchpad = require("chkn.scratchpad")

		assert.is_not_nil(scratchpad._state.win)
		assert.is_true(vim.api.nvim_win_is_valid(scratchpad._state.win))

		vim.cmd("ChknToggle") -- Close the scratchpad
		assert.is_nil(scratchpad._state.win)
	end)
end)
