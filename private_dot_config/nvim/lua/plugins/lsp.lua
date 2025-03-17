return {
	"neovim/nvim-lspconfig",
	config = function()
		require("lspconfig").ruff.setup({})
		require("lspconfig").basedpyright.setup({
			settings = {
				basedpyright = {
					analysis = {
						typeCheckingMode = "strict",
					},
				},
			},
		})
		require("lspconfig").bashls.setup({
			cmd = { "bash-language-server", "start" },
			filetypes = { "bash", "sh" },
		})
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "gr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<C-i>", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
	end,
}
