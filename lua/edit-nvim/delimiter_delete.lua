local M = {}

function M.delimiter_one_delete()
	local delim = vim.fn.input("Left Delimiter: ")
	if delim == "" then
		print("No delimiter provided")
		return
	end

	local current_line = vim.api.nvim_get_current_line()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local new_line = ""

	local start_idx = -1
	local end_idx = -1

	for i = col, 1, -1 do
		local str = current_line:sub(i, i + delim:len() - 1)
		if str == delim then
			start_idx = i
			break
		end
	end

	for i = col + 1, current_line:len(), 1 do
		local str = current_line:sub(i, i + delim:len() - 1)
		if str == delim then
			end_idx = i
			break
		end
	end

	if start_idx == -1 or end_idx == -1 then
		print("No matching delimiter found")
		return
	end

	if start_idx == end_idx then
		return
	end

	new_line = current_line:sub(1, start_idx + delim:len() - 1) .. current_line:sub(end_idx, current_line:len())

	vim.api.nvim_win_set_cursor(0, { row, start_idx + delim:len() - 1 })
	vim.api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
end

function M.delimiter_two_delete()
	local delim1 = vim.fn.input("Left Delimiter: ")
	if delim1 == "" then
		print("No delimiter provided")
		return
	end
	local delim2 = vim.fn.input("Right Delimiter: ")
	if delim2 == "" then
		print("No delimiter provided")
		return
	end

	local current_line = vim.api.nvim_get_current_line()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local new_line = ""

	local start_idx = -1
	local end_idx = -1

	for i = col, 1, -1 do
		local str = current_line:sub(i, i + delim1:len() - 1)
		if str == delim1 then
			start_idx = i
			break
		end
	end

	for i = col + 1, current_line:len(), 1 do
		local str = current_line:sub(i, i + delim2:len() - 1)
		if str == delim2 then
			end_idx = i
			break
		end
	end

	if start_idx == -1 or end_idx == -1 then
		print("No matching delimiter found")
		return
	end

	if start_idx == end_idx then
		return
	end

	new_line = current_line:sub(1, start_idx + delim1:len() - 1) .. current_line:sub(end_idx, current_line:len())

	vim.api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
	vim.api.nvim_win_set_cursor(0, { row, start_idx + delim1:len() - 1 })
end

return M
