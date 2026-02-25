return {
	{
		"nvim-lspconfig",
		event = "DeferredUIEnter",
		after = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end,
	},
	{

		"none-ls.nvim",
		event = "DeferredUIEnter",
		before = function()
			LZN.trigger_load("nvim-lspconfig")
			LZN.trigger_load("blink.cmp")
		end,
		after = function()
			local null_ls = require("null-ls")

			-- code action sources
			local code_actions = null_ls.builtins.code_actions

			-- diagnostic sources
			local diagnostics = null_ls.builtins.diagnostics

			-- formatting sources
			local formatting = null_ls.builtins.formatting

			-- hover sources
			-- local hover = null_ls.builtins.hover

			-- completion sources
			--  local completion = null_ls.builtins.completion

			local ls_sources = {
				formatting.stylua,
				-- formatting.nixfmt,
				-- code_actions.gitsigns,
				-- diagnostics.statix,
				code_actions.statix,
				diagnostics.deadnix,
			}

			-- Enable null-ls
			null_ls.setup({
				diagnostics_format = "[#{m}] #{s} (#{c})",
				debounce = 250,
				default_timeout = 5000,
				sources = ls_sources,
			})
			-- Enable lspconfig
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.diagnostic.config({
				update_in_insert = true,
				virtual_text = false,
				virtual_lines = { enable = true, current_line = true },
				underline = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					linehl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					},
					numhl = {
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			})

			-- vim.lsp.enable({ "nil_ls", "lua_ls", "rust-analyzer", "gopls" })
		end,
		wk = {
			{ "<leader>l", desc = "LSP" },
			{ "<leader>lg", desc = "Decs/Defs" },
			{ "<leader>lw", desc = "Workspace" },
		},

		keys = {
			{
				"<leader>vh",
				function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end,
				desc = "Toggle Inlay Hints",
			},
			{
				"<leader>f",
				function()
					vim.lsp.buf.format({ async = false })
				end,
				desc = "Format",
			},
			{
				"<leader>e",
				function()
					vim.diagnostic.open_float()
				end,
				desc = "Diagnostic Float",
			},
			{
				"<leader>K",
				function()
					vim.lsp.buf.hover()
				end,
				desc = "Hover",
			},
			{
				"<leader>cd",
				function()
					vim.lsp.buf.definition()
				end,
				desc = "Go to definition",
			},
			{
				"<leader>cr",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename",
			},
			{
				"<leader>ca",
				function()
					vim.lsp.buf.code_action()
				end,
				desc = "Code Action",
			},
			{
				"<leader>cu",
				function()
					vim.lsp.buf.references()
				end,
				desc = "Code Action",
			},
			{
				"<Leader>vh",
				function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { desc = "Toggle Inlay Hints" })
				end,
			},
		},
	},
}
