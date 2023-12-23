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
        if opts[k] == nil then
            opts[k] = v
        end
    end

    -- =================
    -- delimiter delete
    -- =================
    vim.keymap.set("n", opts.delimiter_one_delete_key, function()
        require("edit-nvim").delimiter_one_delete()
    end, { desc = "Delete text between a single provided delimiter" })

    vim.keymap.set("n", opts.delimiter_two_delete_key, function()
        require("edit-nvim").delimiter_two_delete()
    end, { desc = "Delete text between two different delimiters" })
end

return M

