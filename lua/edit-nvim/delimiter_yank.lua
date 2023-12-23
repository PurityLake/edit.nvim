local M = {}

local function store_yank_text(text)
	if vim.fn.has("Windows_NT") then
		vim.fn.setreg("*", text)
	else
		vim.fn.setreg("+", text)
	end
end

function M.delimiter_one_yank()
	local delim = vim.fn.input("Left Delimiter: ")
	if delim == "" then
		print("No delimiter provided")
		return
	end
	local current_line = vim.api.nvim_get_current_line()
	local _, col = unpack(vim.api.nvim_win_get_cursor(0))
	local yank_text = ""

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

	yank_text = current_line:sub(start_idx + delim:len() - 1, end_idx - 1)
	store_yank_text(yank_text)
end

function M.delimiter_two_yank()
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
	local _, col = unpack(vim.api.nvim_win_get_cursor(0))
	local yank_text = ""

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

	yank_text = current_line:sub(start_idx + delim:len() - 1, end_idx - 1)
	store_yank_text(yank_text)
end

return M
