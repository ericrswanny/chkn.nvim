local M = {}

local config = {
	width = 80,
	height = 20,
	border = "rounded",
	persistent = true,
	path = vim.fn.stdpath("data") .. "/chkn_scratchpad.txt",
}

local state = {
	buf = nil,
	win = nil,
}

function M.setup(user_config)
	config = vim.tbl_deep_extend("force", config, user_config or {})
end

function M.open()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		-- If the window exists, close it
		vim.api.nvim_win_close(state.win, true)
		state.win = nil
		state.buf = nil
		return
	end

	-- Create the buffer if it doesn't exist or was wiped
	if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
		state.buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_option(state.buf, "bufhidden", "wipe")

		-- Load persistent content if enabled
		if config.persistent and vim.fn.filereadable(config.path) == 1 then
			vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, vim.fn.readfile(config.path))
		end

		-- Set autocommands for persistence
		if config.persistent then
			vim.api.nvim_create_autocmd("BufWriteCmd", {
				buffer = state.buf,
				callback = function()
					M.save(state.buf)
				end,
			})

			vim.api.nvim_create_autocmd("BufWipeout", {
				buffer = state.buf,
				callback = function()
					M.save(state.buf)
				end,
			})
		end
	end

	-- Center the scratchpad
	local width = config.width
	local height = config.height
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create a floating window
	state.win = vim.api.nvim_open_win(state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		border = config.border,
	})

	-- Set window options
	vim.api.nvim_win_set_option(state.win, "wrap", false)
end

function M.save(buf)
	if config.persistent then
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		vim.fn.writefile(lines, config.path)
	end
end

return M
