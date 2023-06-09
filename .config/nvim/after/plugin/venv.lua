vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Auto select virtualenv Nvim open",
	pattern = "*.py",
	callback = function()
		require("venv-selector").retrieve_from_cache()
        vim.cmd.LspRestart()
	end,
	once = true,
})
