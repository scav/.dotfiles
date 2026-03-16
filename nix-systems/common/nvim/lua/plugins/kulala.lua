return {
	"kulala.nvim",
	keys = {
		{
			"<leader>Rs",
			function()
				require("kulala").run()
			end,
			desc = "Send request",
		},
		{
			"<leader>Ra",
			function()
				require("kulala").run_all()
			end,
			desc = "Send all requests",
		},
		{
			"<leader>Rr",
			function()
				require("kulala").replay()
			end,
			desc = "Reply request",
		},
		{
			"<leader>Rb",
			function()
				require("kulala").scratchpad()
			end,
			desc = "Open scratchpad",
		},
	},
	cmd = "Kulala",
	event = { "BufReadPost", "BufNewFile" },
	ft = { "http", "rest" },
	after = function()
		require("kulala").setup({
			global_keymaps = false,
			global_keymaps_prefix = "<leader>R",
			kulala_keymaps_prefix = "",
		})
	end,
}
