--- disable netrw at the very start of your init.lua (strongly advised)
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local tree = require('nvim-tree')

-- empty setup using defaults
tree.setup({
--  open_on_setup = true,
--  ignore_buffer_on_setup = true,
})

vim.keymap.set("n", "<C-t>", [[:NvimTreeToggle<CR>]])
