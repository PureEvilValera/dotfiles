do
	local autoclose_patterns = {
		['"'] = '"',
		["'"] = "'",
		["{"] = "}",
		["("] = ")",
		["["] = "]",
		["<"] = ">",
	}
	for k, v in pairs(autoclose_patterns) do
		vim.api.nvim_set_keymap("i", k, k .. v .. "<left>", { noremap = true })
	end
end
