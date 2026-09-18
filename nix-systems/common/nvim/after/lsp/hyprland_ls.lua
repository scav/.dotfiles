---@type vim.lsp.config
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "hyprland.lua" })
		if root then
			on_dir(root)
		end
	end,
	settings = {
		Lua = {
			workspace = {
				library = { "/run/current-system/sw/share/hypr/stubs" },
			},
			codeLens = {
				enable = true,
			},
			hint = {
				enable = true,
				semicolon = "Disable",
			},
		},
	},
}
