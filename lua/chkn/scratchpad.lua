local M = {}

local config = {
	width = 80,
	height = 20,
	border = "rounded",
	persistent = true,
	path = vim.fn.stdpath("data") .. "/chkn_scratchpad.txt",
}

function M.setup(user_config)
	print(vim.inspect(user_config)) -- Debugging: print user configuration
	config = vim.tbl_deep_extend("force", config, user_config or {})
end

function M.open()
	local width = config.width
	local height = config.height
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		border = config.border,
	})

	vim.api.nvim_win_set_option(win, "wrap", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "chkn_scratchpad")

	if config.persistent and vim.fn.filereadable(config.path) == 1 then
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(config.path))
	end

	if config.persistent then
		vim.api.nvim_create_autocmd("BufWriteCmd", {
			buffer = buf,
			callback = function()
				M.save(buf)
			end,
		})

		vim.api.nvim_create_autocmd("BufWipeout", {
			buffer = buf,
			callback = function()
				M.save(buf)
			end,
		})
	end
end

function M.save(buf)
	if config.persistent then
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		vim.fn.writefile(lines, config.path)
	end
end

return M
