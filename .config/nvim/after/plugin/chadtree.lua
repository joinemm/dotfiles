local chadtree_settings = {
    ["keymap.secondary"] = {},
    ["keymap.tertiary"] = {},
    ["keymap.collapse"] = {"C-enter"},
    ["keymap.quit"] = {"q", "t"},
    ["keymap.trash"] = {}
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

vim.keymap.set("n", "t", ":CHADopen<CR>")
