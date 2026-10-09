return {
	"render-markdown.nvim",
	after = function()
		require("render-markdown").setup({
			completions = { lsp = { enabled = true } },
		})
	end,
	keys = {
		{
			"<leader>mt",
			function()
				require("render-markdown").buf_toggle()
			end,
			desc = "RenderMarkdown: Toggle",
		},
		{
			"<leader>mp",
			function()
				require("render-markdown").preview()
			end,
			desc = "RenderMarkdown: Preview",
		},
	},
}
