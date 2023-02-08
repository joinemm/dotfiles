-- vim.cmd([[highlight IndentBlanklineContextChar guifg=#ebcb8b gui=nocombine]])
require("indent_blankline").setup({
	use_treesitter = true,
	show_current_context = true,
	show_current_context_start = false,
	use_treesitter_scope = true,
})
