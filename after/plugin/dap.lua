local dap, dapui = require("dap"), require("dapui")

dap.adapters.lldb = {
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

local lldb_rust = {
	name = "Launch lldb rust",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/target/debug",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,

    initCommands = function()
      -- build before launching
      vim.fn.jobstart("cargo build")

      -- This pulls in the rust type info

      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

      local commands = {}
      local file = io.open(commands_file, 'r')
      if file then
        for line in file:lines() do
          table.insert(commands, line)
        end
        file:close()
      end
      table.insert(commands, 1, script_import)

      return commands
    end
}
dap.configurations.rust = {
	lldb_rust -- different debuggers or more configurations can be used here
}
dap.configurations.c = lldb
dap.configurations.cpp = lldb

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
--dap.listeners.before.event_terminated["dapui_config"] = function()
--  dapui.close()
--end
--dap.listeners.before.event_exited["dapui_config"] = function()
--  dapui.close()
--end

vim.keymap.set("n", "<leader>d", function() dapui.toggle() end)
vim.keymap.set('n', '<leader>5', function() dap.continue() end)
vim.keymap.set('n', '<leader>0', function() dap.step_over() end)
vim.keymap.set('n', '<leader>-', function() dap.step_into() end)
vim.keymap.set('n', '<leader>=', function() dap.step_out() end)
vim.keymap.set('n', '<leader>9', function() dap.toggle_breakpoint() end)
