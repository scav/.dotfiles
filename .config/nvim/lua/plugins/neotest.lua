local Plugin = { 'nvim-neotest/neotest' }

Plugin.dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'antoinemadec/FixCursorHold.nvim' },
    { 'nvim-neotest/neotest-go' },
    { 'rouge8/neotest-rust' }
}

function Plugin.config()
    local neotest = require('neotest')

    neotest.setup({
        -- your neotest config here
        neotest = {
            options = {
                go = {
                    buildFlags = { "-tags=mocks" }
                },
            },
        },
        adapters = {
            require("neotest-go"),
            require("neotest-rust") {
                args = { "--no-capture" },
            }
        },
    })

    vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Test Run" })
    vim.keymap.set("n", "<leader>tt", neotest.output_panel.toggle, { desc = "Test Output" })
    vim.keymap.set("n", "<leader>ttt", neotest.summary.toggle, { desc = "Test Summary" })
    vim.keymap.set('n', '<leader>ttr', function()
        neotest.output.open({ enter = true })
    end, { desc = "Test Open Output" })
    vim.keymap.set("n", "<leader>tw", function()
        neotest.watch.toggle({ vim.fn.expand("%") })
    end, { desc = "Test Watcher" })
end

return Plugin
