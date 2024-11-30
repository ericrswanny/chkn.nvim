-- Set runtime path to include the plugin
vim.cmd("set rtp+=.")
vim.cmd("set rtp+=~/.local/share/nvim/lazy/plenary.nvim") -- Adjust path as needed

-- Load the scratchpad module and register the ChknToggle command
local scratchpad = require("chkn.scratchpad")
vim.api.nvim_create_user_command("ChknToggle", function()
	scratchpad.open()
end, { desc = "Toggle the scratchpad" })

-- Load Plenary's testing framework
require("plenary.busted")
