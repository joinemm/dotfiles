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
		typescript = { require("formatter.filetypes.typescript").prettier },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },

		json = { require("formatter.filetypes.json").prettier },

		python = {
			require("formatter.filetypes.python").isort,
			require("formatter.filetypes.python").autopep8,
			function()
				return {
					exe = "black",
					args = { "-q", "-", "--line-length=88"},
					stdin = true,
				}
			end,
		},

		sh = { require("formatter.filetypes.sh").shfmt },

		nix = { require("formatter.filetypes.nix").alejandra },

		rust = { require("formatter.filetypes.rust").rustfmt },

		c = { require("formatter.filetypes.c").clangformat },

		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})
