return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local tree = require("neo-tree")

		tree.setup({
			document_symbols = {
				custom_kinds = {},
			},
		})
		vim.keymap.set("n", "<F2>", "<CMD>Neotree toggle<CR>")
	end,
}
