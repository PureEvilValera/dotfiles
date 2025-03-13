return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		--local telescopeExtensions = {}
		--for i, extension in ipairs(telescopeExtensions) do
		--    require("telescope").load_extension(extension)
		--end
		--require("telescope").setup({
		--  pickers = {
		--    colorscheme = {
		--      enable_preview = true
		--    }
		--  }
		--})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files()
		end, opts)
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep()
		end, opts)
		vim.keymap.set("n", "<leader>fb", function()
			builtin.buffers()
		end, opts)
	end,
}
