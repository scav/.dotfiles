local Plugin = { 'nvim-neotest/neotest' }

Plugin.dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-neotest/nvim-nio' },
    { 'antoinemadec/FixCursorHold.nvim' },
    { 'nvim-neotest/neotest-go' },
    { 'rouge8/neotest-rust' }
}

function Plugin.config()
    local neotest = require('neotest')

    neotest.setup({
        neotest = {
            options = {
                go = {
                    buildFlags = { "-tags=mocks" }
                },
            },
        },
        adapters = {
            require("neotest-go")({
                experimental = {
                    test_table = true,
                },
                args = { "-count=1", "-timeout=60s" }
            }),
            require("neotest-rust") {
                args = { "--no-capture" },
            }
        },
    })

    vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Test Run" })
    vim.keymap.set("n", "<leader>ts", neotest.run.stop, { desc = "Stop running test" })
    vim.keymap.set("n", "<leader>tt", neotest.output_panel.toggle, { desc = "Test Output" })
    vim.keymap.set("n", "<leader>ttc", neotest.output_panel.clear, { desc = "Clear Test Output" })
    vim.keymap.set("n", "<leader>ttt", neotest.summary.toggle, { desc = "Test Summary" })
    vim.keymap.set('n', '<leader>ttr', function()
        neotest.output.open({ enter = true })
    end, { desc = "Test Open Output" })
    vim.keymap.set("n", "<leader>tw", function()
        neotest.watch.toggle({ vim.fn.expand("%") })
    end, { desc = "Test Watcher" })
end

return Plugin
