local delim_delete = require("edit-nvim.delimiter_delete")

local M = {}

M.delimiter_delete = delim_delete.delimiter_delete

local default_opts = {
    delimiter_delete = "dd",
}

function M.setup(opts)
    opts = opts or default_opts
    vim.keymap.set("n", "<leader>" .. opts.delimiter_delete, function()
        local input = vim.fn.input("Delimiter: ")
        if input == "" then
            print("No delimiter provided")
            return
        end
        require("edit-nvim").delimiter_delete(input)
    end)
end

return M

