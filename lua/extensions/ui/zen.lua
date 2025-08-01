local M = {}

-- State table to track UI elements
M.ui_state = {
    enabled = false,
    number = vim.o.nu,
    relativenumber = vim.o.relativenumber,
    signs = true,
    bars = true,
    saved_layout = nil, -- Store window layout when entering minimal mode
    saved_curwin = nil, -- Store current window ID to restore focus later
    saved_buffers = nil, -- Store mapping of window IDs to buffer numbers
}

local function toggle_indent_scope()
    vim.b.miniindentscope_disable = not vim.b.miniindentscope_disable
end

function M.toggle_clean()
    M.ui_state.bars = not M.ui_state.bars
    M.ui_state.signs = not M.ui_state.signs

    require("lualine").hide {
        place = { "statusline" },
        unhide = M.ui_state.bars,
    }

    toggle_indent_scope()
    require("barbecue.ui").toggle()

    vim.o.signcolumn = M.ui_state.signs and "yes" or "no"

    require("gitsigns").toggle_signs()

    -- TODO: remove diagnostic underline
end

function M.toggle_minimal()
    M.toggle_clean()
    M.ui_state.enabled = not M.ui_state.enabled

    if M.ui_state.enabled then
        -- Save current state before entering minimal mode
        M.ui_state.number = vim.o.nu
        M.ui_state.relativenumber = vim.o.relativenumber

        -- Save the current window layout and active window ID
        M.ui_state.saved_layout = vim.fn.winlayout()
        M.ui_state.saved_curwin = vim.fn.win_getid()

        -- Save buffer information for each window
        M.ui_state.saved_buffers = {}
        for _, win_id in ipairs(vim.api.nvim_list_wins()) do
            local buf_id = vim.api.nvim_win_get_buf(win_id)
            M.ui_state.saved_buffers[win_id] = buf_id
        end

        -- Enter minimal mode
        vim.o.nu = false
        vim.o.relativenumber = false
        vim.cmd [[only]]
    else
        -- Restore normal state
        vim.o.nu = M.ui_state.number
        vim.o.relativenumber = M.ui_state.relativenumber

        -- Restore window layout if we have a saved layout
        if M.ui_state.saved_layout and M.ui_state.saved_buffers then
            -- Create a mapping of old window IDs to new window IDs
            local win_id_map = {}

            local function restore_layout(layout, parent_win)
                local layout_type = layout[1]

                if layout_type == "leaf" then
                    -- This is a leaf node (an actual window)
                    local old_win_id = layout[2]

                    -- Record the mapping from old window ID to new window ID
                    win_id_map[old_win_id] = parent_win

                    -- Restore the buffer that was in this window
                    if M.ui_state.saved_buffers[old_win_id] then
                        local buf_id = M.ui_state.saved_buffers[old_win_id]
                        -- Only set the buffer if it still exists
                        if vim.api.nvim_buf_is_valid(buf_id) then
                            vim.api.nvim_win_set_buf(parent_win, buf_id)
                        end
                    end

                    return parent_win
                elseif layout_type == "col" or layout_type == "row" then
                    -- This is a container node (column or row of windows)
                    local splits = layout[2]
                    local first_win = nil
                    local prev_win = nil

                    -- Process each child in the layout
                    for i, child_layout in ipairs(splits) do
                        -- Determine split command based on layout type
                        local win_cmd = layout_type == "col" and "split" or "vsplit"

                        if i == 1 then
                            -- For the first window, use the parent window
                            vim.fn.win_gotoid(parent_win)
                            first_win = restore_layout(child_layout, parent_win)
                            prev_win = first_win
                        else
                            -- For subsequent windows, split from the previous window
                            vim.fn.win_gotoid(prev_win)
                            vim.cmd(win_cmd)
                            local new_win = vim.fn.win_getid()
                            prev_win = restore_layout(child_layout, new_win)
                        end
                    end

                    return prev_win
                end
            end

            -- Start restoration with the current window
            restore_layout(M.ui_state.saved_layout, vim.fn.win_getid())

            -- Try to focus the window that was active before entering minimal mode
            if M.ui_state.saved_curwin then
                local new_win_id = win_id_map[M.ui_state.saved_curwin]
                if new_win_id and vim.fn.win_id2win(new_win_id) > 0 then
                    vim.fn.win_gotoid(new_win_id)
                end
            end

            -- Clear saved layout data
            M.ui_state.saved_layout = nil
            M.ui_state.saved_curwin = nil
            M.ui_state.saved_buffers = nil
        end
    end
end

-- Export toggle_indent_scope for external use
M.toggle_indent_scope = toggle_indent_scope

return M
