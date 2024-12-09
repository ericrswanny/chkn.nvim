local scratchpad = require("chkn.scratchpad")

describe("Scratchpad functionality", function()
	before_each(function()
		-- Set up the scratchpad configuration before each test
		scratchpad.setup({
			width = 80,
			height = 20,
			border = "rounded",
			persistent = false,
		})
    scratchpad.close()
	end)

	it("should set up configuration correctly", function()
		-- Access the configuration from the plugin
		local config = scratchpad._config
		assert.is_not_nil(config)
		assert.are.equal(80, config.width)
		assert.are.equal(20, config.height)
		assert.are.equal("rounded", config.border)
	end)

	it("should toggle the scratchpad window", function()
		scratchpad.open()
		local state = scratchpad.get_state()
		assert.is_not_nil(state.win)
		assert.is_true(vim.api.nvim_win_is_valid(state.win))

		scratchpad.open()
		assert.is_nil(state.win)
	end)

	it("should create a new buffer for the scratchpad", function()
		-- Open the scratchpad
		scratchpad.open()
		assert.is_not_nil(scratchpad._state.buf)
		assert.is_true(vim.api.nvim_buf_is_valid(scratchpad._state.buf))
	end)

  it("should close the scratchpad when 'q' is pressed", function()
      -- Open the scratchpad
      scratchpad.open()
      local state = scratchpad.get_state()

      -- Ensure the scratchpad window is open
      assert.is_not_nil(state.win)
      assert.is_true(vim.api.nvim_win_is_valid(state.win))

      -- Debug keymaps and verify 'q' is bound to the close function
      local keymaps = vim.api.nvim_buf_get_keymap(state.buf, "n")
      local found_q = false
      for _, map in ipairs(keymaps) do
          if map.lhs == "q" then
              found_q = true
              -- Assert that the keybinding executes the close function
              assert.is_true(
                  map.rhs == ":lua require('chkn.scratchpad').close()<CR>",
                  "Keybinding 'q' is not mapped to the close function"
              )
              break
          end
      end
      assert.is_true(found_q, "Keybinding 'q' not found on the scratchpad buffer")

      -- Focus the scratchpad window
      vim.api.nvim_set_current_win(state.win)

      -- Execute the `q` keybinding directly
      vim.cmd(":lua require('chkn.scratchpad').close()")

      -- Ensure the scratchpad window is closed
      assert.is_nil(state.win, "Expected scratchpad window to be closed, but it is still open.")
  end)
end)
