return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"kristijanhusak/vim-dadbod-completion",
		"MahanRahmati/blink-nerdfont.nvim",
	},
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "default",
			["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
			["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },

			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-y>"] = { "select_and_accept", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
			["<C-e>"] = { "cancel", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = { documentation = { auto_show = false } },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			-- default = { "lsp", "path", "snippets", "buffer", "nerdfont" },
			per_filtype = {
				sql = { "snippets", "dadbod", "buffer" },
			},
		},
		providers = {
			dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			-- nerdfont = {
			-- 	module = "blink-nerdfont",
			-- 	name = "Nerd Fonts",
			-- 	score_offset = 15, -- Tune by preference
			-- 	opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
			-- },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}

