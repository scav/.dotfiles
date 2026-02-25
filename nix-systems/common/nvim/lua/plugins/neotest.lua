return {
    "neotest",
    before = function()
        LZN.trigger_load("plenary-nvim")
        LZN.trigger_load("nvim-treesitter")
        LZN.trigger_load("nvim-nio")
        LZN.trigger_load("neotest-rust")
        LZN.trigger_load("neotest-golang")
    end,
    event = { "BufReadPost", "BufNewFile" },
    after = function()
        local neotest = require("neotest")

        neotest.setup({
            neotest = {
                options = {
                    go = {
                        buildFlags = { "-tags=mocks" },
                    },
                },
            },
            adapters = {
                require("neotest-golang")({
                    runner = "gotestsum",
                    gotestsum_args = { "--format=standard-verbose" },
                    go_test_args = { "-count=1", "-timeout=60s" },
                    dap_mode = "dap-go",
                    testify_enabled = true,
                    sanitize_output = false,
                }),
                require("neotest-rust")({
                    args = { "--no-capture" },
                }),
            },
        })

        vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Test Run" })
        vim.keymap.set("n", "<leader>ts", neotest.run.stop, { desc = "Stop running test" })
        vim.keymap.set("n", "<leader>tt", neotest.output_panel.toggle, { desc = "Test Output" })
        vim.keymap.set("n", "<leader>ttc", neotest.output_panel.clear, { desc = "Clear Test Output" })
        vim.keymap.set("n", "<leader>ttt", neotest.summary.toggle, { desc = "Test Summary" })
        vim.keymap.set("n", "<leader>ttr", function()
            neotest.output.open({ enter = true })
        end, { desc = "Test Open Output" })
        vim.keymap.set("n", "<leader>tw", function()
            neotest.watch.toggle({ vim.fn.expand("%") })
        end, { desc = "Test Watcher" })
    end,
}
