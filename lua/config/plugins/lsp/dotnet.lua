return {
	{
		"easy-dotnet.nvim",
		ft = { "cs", "fs", "vb", "sln", "csproj", "fsproj" },
		setup = {},
		after = function()
			local dap = require("dap")

			-- Keymap("n", "q", function()
			-- 	dap.terminate()
			-- 	dap.clear_breakpoints()
			-- end, { desc = "Terminate and clear breakpoints" })

			Keymap("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
			Keymap("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			Keymap("n", "<F10>", dap.step_over, { desc = "Step over" })
			Keymap("n", "<F11>", dap.step_into, { desc = "Step into" })
			Keymap("n", "<F12>", dap.step_out, { desc = "Step out" })
			Keymap("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
			Keymap("n", "<leader>dr", dap.run_to_cursor, { desc = "Toggle DAP REPL" })
			Keymap("n", "<leader>dcb", dap.clear_breakpoints, { desc = "[D]ebug [C]lear [B]reakpoints" })
		end,
	},
}
