return {
	-- Bilingual typing: normal-mode commands work while the RU layout is active.
	{
		"mrsobakin/multilayout.nvim",
		event = "VeryLazy",
		opts = {
			layouts = {
				ru = "ru",
			},
			-- Enable if you want full multilayout.nvim functionality.
			use_libukb = false,
		},
	},
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1, -- High priority is needed if you use `autoremap()`

		-- See lua/plugins/ui.lua / which-key
		config = function()
			require("langmapper").setup({})
		end,
	},
}
