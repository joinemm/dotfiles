-- Utilities for creating configurations
local util = require("formatter.util")

vim.keymap.set("n", "<leader>f", vim.cmd.Format)
vim.keymap.set("n", "<leader>F", vim.cmd.FormatWrite)

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },

		javascript = { require("formatter.filetypes.javascript").prettier },

		python = { require("formatter.filetypes.python").black },

		sh = { require("formatter.filetypes.sh").shfmt },

		nix = { require("formatter.filetypes.nix").alejandra },

		rust = { require("formatter.filetypes.rust").rustfmt },

		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})
