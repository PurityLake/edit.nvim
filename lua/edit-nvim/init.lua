local delim_delete = require("edit-nvim.delimiter_delete")
local delim_yank = require("edit-nvim.delimiter_yank")
local M = {}

M.delimiter_one_delete = delim_delete.delimiter_one_delete
M.delimiter_two_delete = delim_delete.delimiter_two_delete
M.delimiter_one_yank = delim_yank.delimiter_one_yank
M.delimiter_two_yank = delim_yank.delimiter_two_yank

local function fill_table(tbl, default)
    for k, v in pairs(default) do
        if tbl[k] == nil then
            tbl[k] = v
        else
            if type(v) == "table" then
                if type(tbl[k]) ~= "table" then
                    tbl[k] = v
                else
                    fill_table(tbl[k], v)
                end
            end
        end
    end
end

local default_opts = {
    mappings = {
        delete = {
            one = "<leader>d1",
            two = "<leader>d2",
        },
        yank = {
            one = "<leader>y1",
            two = "<leader>y2",
        },
    },
}

function M.setup(opts)
    opts = opts or {}

    fill_table(opts, default_opts)

    -- =================
    -- delimiter delete
    -- =================
    vim.keymap.set("n", opts.mappings.delete.one, function()
        require("edit-nvim").delimiter_one_delete()
    end, { desc = "Delete text between a single provided delimiter" })

    vim.keymap.set("n", opts.mappings.delete.two, function()
        require("edit-nvim").delimiter_two_delete()
    end, { desc = "Delete text between two different delimiters" })

    -- =================
    -- delimiter yank
    -- =================
    vim.keymap.set("n", opts.mappings.yank.one, function()
        require("edit-nvim").delimiter_one_yank()
    end, { desc = "Yank text between a single provided delimiter" })

    vim.keymap.set("n", opts.mappings.yank.two, function()
        require("edit-nvim").delimiter_two_yank()
    end, { desc = "Yank text between two different delimiters" })
end

return M

