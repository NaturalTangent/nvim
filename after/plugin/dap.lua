require("dap").adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
}

local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

require('dap').configurations.rust = {
	lldb -- different debuggers or more configurations can be used here
}

vim.keymap.set('n', '<leader>5', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>0', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>-', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>=', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>9', function() require('dap').toggle_breakpoint() end)
