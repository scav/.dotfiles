-- Check if its a Git repository
local function in_git(Snacks)
    return Snacks.git.get_root() ~= nil
end

-- Check if Git repository has a GitHub remote
local function is_gh(Snacks)
    local in_git = in_git(Snacks)
    local is_gh = false
    if in_git then
        local handle = io.popen("git remote")
        local result = handle:read("*a")
        handle:close()
        is_gh = result:match("%S") ~= nil
    end

    return is_gh
end

local Plugin = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        quickfile = { enabled = true },
        statuscolumn = { enabled = false },
        words = { enabled = true },
        bigfile = { enabled = true },
        input = { enabled = false },
        animate =
        ---@class snacks.scroll.Config
        ---@field animate snacks.animate.Config
        {
            duration = { step = 15, total = 250 },
            easing = "linear",
        },
        notifier =
        ---@class snacks.notifier.Config
        ---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
        {
            timeout = 3000, -- default timeout in ms
            width = { min = 40, max = 0.4 },
            height = { min = 1, max = 0.6 },
            -- editor margin to keep free. tabline and statusline are taken into account automatically
            margin = { top = 0, right = 1, bottom = 0 },
            padding = true,              -- add 1 cell of left/right padding to the notification window
            sort = { "level", "added" }, -- sort by level and time
            -- minimum log level to display. TRACE is the lowest
            -- all notifications are stored in history
            level = vim.log.levels.TRACE,
            icons = {
                error = " ",
                warn = " ",
                info = " ",
                debug = " ",
                trace = " ",
            },
            keep = function(notif)
                return vim.fn.getcmdpos() > 0
            end,
            ---@type snacks.notifier.style
            style = "compact",
            top_down = true,    -- place notifications from top to bottom
            date_format = "%R", -- time format for notifications
            -- format for footer when more lines are available
            -- `%d` is replaced with the number of lines.
            -- only works for styles with a border
            ---@type string|boolean
            more_format = " ↓ %d lines ",
            refresh = 50, -- refresh at most every 50ms
        },
        dashboard =
        ---@class snacks.dashboard.Config
        ---@field sections snacks.dashboard.Section
        ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
        {
            preset = {
                header = { 'foo' },
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "M", desc = "Mason", action = ":Mason" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                {
                    pane = 1,
                    desc = "Shortcuts",
                    height = 1,
                    padding = 1,
                },
                {
                    function()
                        if is_gh(Snacks) then
                            return {
                                pane = 2,
                                desc = "GitHub",
                                height = 1,
                                padding = 1,
                            }
                        end
                    end
                },
                { section = "keys",    gap = 1,     padding = 1 },
                { function()
                    if is_gh(Snacks) then
                        return {
                            pane = 2,
                            icon = " ",
                            desc = "Browse Repo",
                            padding = 1,
                            key = "b",
                            action = function()
                                Snacks.gitbrowse()
                            end,
                        }
                    end
                end
                },
                function()
                    local cmds = {}
                    if in_git(Snacks) then
                        cmds = {
                            {
                                icon = " ",
                                title = "Git Status",
                                cmd = "git --no-pager diff --stat -B -M -C",
                                height = 10,
                            },
                        }
                    end
                    if is_gh(Snacks) then
                        local gh_cmds = {
                            {
                                title = "Notifications",
                                cmd = "gh notify -s -a -n5",
                                action = function()
                                    vim.ui.open("https://github.com/notifications")
                                end,
                                key = "n",
                                icon = " ",
                                height = 5,
                                enabled = true,
                            },
                            {
                                title = "Open Issues",
                                cmd = "gh issue list -L 3",
                                key = "i",
                                action = function()
                                    vim.fn.jobstart("gh issue list --web", { detach = true })
                                end,
                                icon = " ",
                                height = 7,
                            },
                            {
                                icon = " ",
                                title = "Open PRs",
                                cmd = "gh pr list -L 3",
                                key = "p",
                                action = function()
                                    vim.fn.jobstart("gh pr list --web", { detach = true })
                                end,
                                height = 7,
                            },
                        }
                        vim.tbl_extend("force", gh_cmds, cmds)
                    end
                    return vim.tbl_map(function(cmd)
                        return vim.tbl_extend("force", {
                            pane = 2,
                            section = "terminal",
                            enabled = is_gh(Snacks),
                            padding = 1,
                            ttl = 5 * 60,
                            indent = 3,
                        }, cmd)
                    end, cmds)
                end,
                { section = "startup", padding = 10 },
            },
        }

    }
}
return Plugin
