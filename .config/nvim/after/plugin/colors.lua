function ColorMyPencils(color)
	vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#eaeaea" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = true })
	vim.api.nvim_set_hl(0, "CursorLineNr", { link = "CursorLine" })
	vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#000000" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

ColorMyPencils("dracula")
