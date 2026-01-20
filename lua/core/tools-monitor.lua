local M = {}

local group = vim.api.nvim_create_augroup("ToolManager", { clear = true })

-- Singleton state
M._initialized = false
M._monitored = false

-- Default ignored filetypes (can be overridden)
M.ignored_filetypes = {
    [""] = true,
    ["help"] = true,
    ["checkhealth"] = true,
    ["telescope"] = true,
    ["NvimTree"] = true,
    ["notify"] = true,
    ["lazy"] = true,
    ["alpha"] = true,
}

-- Configuration for tools (to be set by user)
M.tools = {}

-- Helper function to check if tool binary is installed
local function is_binary_installed(bin_name)
    return vim.fn.executable(bin_name) == 1
end

-- Helper function to show notification
local function notify(title, message, level)
    vim.notify(message, level, { title = title })
end

-- Check if tool already exists
local function tool_exists(new_tool)
    for _, existing_tool in ipairs(M.tools) do
        if existing_tool.name == new_tool.name then
            return true
        end
    end
    return false
end

-- Execute a tool when a filetype is opened
local function setup_tool_execution(tool)
    -- Setup autocmd to execute the tool when filetype is opened
    if tool.onExecutable and tool.filetype then
        local filetypes = type(tool.filetype) == "table" and tool.filetype or { tool.filetype }

        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = filetypes,
            callback = function(args)
                local bufnr = args.buf

                -- Handle different types of onExecutable
                if type(tool.onExecutable) == "function" then
                    -- Call the function with buffer number
                    tool.onExecutable(bufnr)
                elseif type(tool.onExecutable) == "string" then
                    -- Execute the command string
                    vim.cmd(tool.onExecutable)
                else
                    notify(
                        tool.title or "Tool Manager",
                        "Invalid onExecutable type for " .. (tool.name or "unnamed tool"),
                        vim.log.levels.ERROR
                    )
                end
            end,
        })
    end

    return true
end

-- Monitor a single tool
local function monitor_tool(tool)
    -- Check if binary is installed
    local binary_installed = is_binary_installed(tool.bin)

    if not binary_installed then
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = tool.filetype,
            callback = function()
                notify(
                    tool.title or "Tool Manager",
                    "💡 " .. tool.name .. " isn't installed. Use <leader>ll to install.",
                    vim.log.levels.WARN
                )
            end,
            once = true,
        })
        return false
    end

    -- If binary is installed, set up the execution
    setup_tool_execution(tool)

    return true
end

-- Add tools to existing configuration
local function add_tools(new_tools)
    for _, new_tool in ipairs(new_tools) do
        if not tool_exists(new_tool) then
            table.insert(M.tools, new_tool)
        else
            notify(
                "Tool Manager",
                "Tool '" .. (new_tool.name or new_tool.bin) .. "' already exists, skipping.",
                vim.log.levels.INFO
            )
        end
    end
end

-- Main monitoring function (can be called multiple times)
M.monitor = function()
    local supported_fts = {}
    local installed_tools = {}

    for _, tool in ipairs(M.tools) do
        -- Ensure required fields exist
        if not tool.filetype or not tool.bin then
            notify("Tool Manager", "Tool configuration missing required fields (filetype and bin)", vim.log.levels.ERROR)
            goto continue
        end

        -- Map supported filetypes
        if type(tool.filetype) == "table" then
            for _, ft in ipairs(tool.filetype) do
                supported_fts[ft] = true
            end
        else
            supported_fts[tool.filetype] = true
        end

        -- Only monitor if not already monitored
        local already_monitored = false
        for _, monitored_tool in ipairs(installed_tools) do
            if monitored_tool == (tool.name or tool.bin) then
                already_monitored = true
                break
            end
        end

        if not already_monitored then
            if monitor_tool(tool) then
                table.insert(installed_tools, tool.name or tool.bin)
            end
        end

        ::continue::
    end

    -- Only setup global check once
    if not M._monitored then
        -- Global check for unsupported languages
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            callback = function(args)
                local ft = vim.bo[args.buf].filetype

                -- Skip if filetype is ignored or already supported
                if M.ignored_filetypes[ft] or supported_fts[ft] then
                    return
                end

                notify(
                    "Tool Manager",
                    "🚫 Language '" .. ft .. "' is not yet supported by installer.",
                    vim.log.levels.INFO
                )
            end,
        })

        M._monitored = true
    end

    -- Log installed tools
    if #installed_tools > 0 then
        notify("Tool Manager", "Tools ready: " .. table.concat(installed_tools, ", "), vim.log.levels.INFO)
    end
end

-- Singleton setup function
M.setup = function(opts)
    opts = opts or {}

    -- Merge ignored filetypes
    if opts.ignored_filetypes then
        for ft, _ in pairs(opts.ignored_filetypes) do
            M.ignored_filetypes[ft] = true
        end
    end

    -- Add tools (merge, don't replace)
    if opts.tools then
        add_tools(opts.tools)
    end

    -- Mark as initialized
    M._initialized = true

    return M
end

return M
