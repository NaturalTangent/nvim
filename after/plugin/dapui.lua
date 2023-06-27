local dapui = require('dapui')

dapui.setup();

vim.keymap.set("n", "<C-d>", function() dapui.toggle() end)
