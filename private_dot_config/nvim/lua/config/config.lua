do
	local neovim_options = {
		expandtab = true,
		number = true,
		shiftwidth = 2,
		tabstop = 2,
		termguicolors = true,
		clipboard = "unnamedplus",
	}

	for k, v in pairs(neovim_options) do
		vim.opt[k] = v
	end
end
