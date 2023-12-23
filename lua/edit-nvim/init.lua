local delim_delete = require("edit-nvim.delimiter_delete")

local M = {}

M.delimiter_one_delete = delim_delete.delimiter_one_delete
M.delimiter_two_delete = delim_delete.delimiter_two_delete

local default_opts = {
	delimiter_one_delete_key = "<leader>d1",
	delimiter_two_delete_key = "<leader>d2",
}

function M.setup(opts)
	opts = opts or {}
	for k, v in pairs(default_opts) do
		if not opts[k] then
			opts[k] = v
		end
	end

	vim.keymap.set("n", opts.delimiter_one_delete_key, function()
		local input = vim.fn.input("Delimiter: ")
		if input == "" then
			print("No delimiter provided")
			return
		end
		require("edit-nvim").delimiter_one_delete(input)
	end, { desc = "Delete text between a single provided delimiter" })

	vim.keymap.set("n", opts.delimiter_two_delete_key, function()
		local input1 = vim.fn.input("Left Delimiter: ")
		if input1 == "" then
			print("No delimiter provided")
			return
		end
		local input2 = vim.fn.input("Right Delimiter: ")
		if input2 == "" then
			print("No delimiter provided")
			return
		end
		require("edit-nvim").delimiter_two_delete(input1, input2)
	end, { desc = "Delete text between two different delimiters" })
end

return M
