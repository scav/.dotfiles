return {
	"markview",
	before = function()
		LZN.trigger_load("plenary-nvim")
		LZN.trigger_load("nvim-treesitter")
		LZN.trigger_load("nvim-nio")
		LZN.trigger_load("neotest-rust")
		LZN.trigger_load("neotest-golang")
	end,
	event = { "BufReadPost", "BufNewFile" },
	lazy = false,
	after = function() end,
	keys = {
		{
			"<leader>mt",
			"<CMD>Markview toggle<CR>",
			desc = "Markview Toggle",
		},
		{
			"<leader>ms",
			"<CMD>Markview splitToggle<CR>",
			desc = "Markview Split Toggle",
		},
	},
}
