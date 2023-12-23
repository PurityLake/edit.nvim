local M = {}

local function distance(a, b)
    return math.abs(a - b)
end

function M.delimiter_delete(delim)
    local current_line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local new_line = ""

    local pos_step = #delim
    local neg_step = -pos_step

    local start_idx = -1
    local end_idx = -1

    for i = col, 1, -1 do
        local str = current_line:sub(i, i + #delim - 1)
        if str == delim then
            start_idx = i
            break
        end
    end

    for i = col, #current_line, 1 do
        local str = current_line:sub(i, i + #delim - 1)
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

    new_line = current_line:sub(1, start_idx + #delim - 1) .. current_line:sub(end_idx, #current_line)

    local new_col = -1
    if distance(col, start_idx) < distance(col, end_idx) then
        new_col = start_idx
    else
        new_col = end_idx
    end

    vim.api.nvim_win_set_cursor(0, { row, new_col })
    vim.api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
end

return M

