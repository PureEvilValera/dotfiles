return {
	"neovim/nvim-lspconfig",
	config = function()
		-- source https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-877293306
		local function get_python_path()
			local util = require("lspconfig/util")
			local path = util.path
			local workspace = vim.fn.getcwd()
			-- Use activated virtualenv.
			if vim.env.VIRTUAL_ENV then
				return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
			end

			-- Find and use virtualenv via poetry in workspace directory.
			local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
			if match ~= "" then
				local venv = vim.fn.trim(vim.fn.system("poetry env info -p 2> /dev/null"))
				return path.join(venv, "bin", "python")
			end

			-- Fallback to system Python.
			return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
		end

		require("lspconfig").ruff.setup({
			settings = {
				interpreter = get_python_path(),
			},
		})
		require("lspconfig").basedpyright.setup({
			settings = {
				python = {
					pythonPath = get_python_path(),
				},
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
