return {
	"oil.nvim",
	before = function()
		LZN.trigger_load("nvim-web-devicons")
	end,
	after = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = false, -- yolo
			columns = {
				"icon",
			},
			lsp_file_methods = {
				enabled = true,
				timeout_ms = 1000,
				autosave_changes = true,
			},
			view_options = {
				natural_order = true,
				show_hidden = true,
			},
			watch_for_changes = true,
		})
	end,
	keys = {
		{
			"<leader>pv",
			"<CMD>Oil<CR>",
			desc = "Oil: Open",
		},
		{
			"<leader>pd",
			function()
				detail = not detail
				if detail then
					require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
				else
					require("oil").set_columns({ "icon" })
				end
			end,
			desc = "Oil: Toogle details",
		},
	},
}
