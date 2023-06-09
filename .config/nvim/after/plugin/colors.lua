function ColorMyPencils(color)
	color = color or "moonfly"
	vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#eaeaea" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "MoonflyRed" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { link = "MoonflyYellow" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { link = "MoonflyBlue" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { link = "MoonflyWhite" })
end

ColorMyPencils()
