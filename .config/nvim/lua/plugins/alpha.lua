local Plugin = { "goolord/alpha-nvim" }

Plugin.dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim'
}

local function footer()
    -- todo add some useful info here
    return ""
end

-- set version string
local function version()
    local v = vim.version()
    local version = v.major .. "." .. v.minor .. "." .. v.patch
    return version

    -- local dev = ""
    -- if v.prerelease == "dev" then
    --     dev = "-dev+" .. v.build .. " (" .. v.prerelease .. ")"
    -- else
    --     dev = ""
    -- end
    --
    -- local version = v.major .. "." .. v.minor .. "." .. v.patch .. dev
    -- return "neovim " .. version
end

function Plugin.config()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        version(),
        [[                                                                       ]],
        [[                                                                       ]],
    }

    _Gopts = {
        position = "center",
        hl = "Type",
    }

    dashboard.section.footer.val = footer()

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    require("alpha").setup(dashboard.opts)

    -- vim.api.nvim_create_autocmd("User", {
    -- 	pattern = "LazyVimStarted",
    -- 	callback = function()
    -- 		local stats = require("lazy").stats()
    -- 		local count = (math.floor(stats.startuptime * 100) / 100)
    -- 		dashboard.section.footer.val = {
    -- 			"󱐌 " .. stats.count .. " plugins loaded in " .. count .. " ms",
    -- 			" ",
    -- 			"      Mohammed Babiker Babai",
    -- 		}
    -- 		pcall(vim.cmd.AlphaRedraw)
    -- 	end,
    -- })
end

return Plugin
