local M = {}

function M.delimiter_delete(c)
    local current_line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local new_line = ""

    local start_idx = -1
    local end_idx = -1

    for i = col, 1, -1 do
        local ch = current_line[i]
        if ch == c then
            start_idx = i
            break
        end
    end

    for i = col, #current_line do
        local ch = current_line[i]
        if ch == c then
            end_idx = i
            break
        end
    end

    if start_idx == -1 or end_idx == -1 then
        print("No matching delimiter found")
        return
    end

    new_line = current_line:sub(1, start_idx - 1) .. current_line:sub(end_idx + 1, #current_line)

    vim.api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
end

return M

