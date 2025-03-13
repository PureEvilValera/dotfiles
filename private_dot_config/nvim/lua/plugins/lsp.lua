return {
	"neovim/nvim-lspconfig",
	config = function()
		require("lspconfig").ruff.setup({})
		require("lspconfig").basedpyright.setup({})
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
	end,
}
