return {
	{
		"nvim-dap",
		on_plugin = { "nvim-dap-view" },
		after = function()
			local dap = require("dap")

			dap.defaults.fallback.external_terminal = {
				command = "kitty",
				args = { "--hold" },
			}

			vim.fn.sign_define({
				{
					name = "DapBreakpoint",
					text = " ",
					texthl = "BreakpointIcon",
					linehl = "BreakpointLine",
					numhl = "BreakpointNumber",
				},
				{
					name = "DapBreakpointCondition",
					text = " ",
					texthl = "BreakpointConditionIcon",
					linehl = "BreakpointLine",
					numhl = "BreakpointNumber",
				},
				{
					name = "DapBreakpointRejected",
					text = " ",
					texthl = "BreakpointRejectedIcon",
					linehl = "",
					numhl = "",
				},
			})

			Keymap("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
			Keymap("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			Keymap("n", "<F10>", dap.step_over, { desc = "Step over" })
			Keymap("n", "<F11>", dap.step_into, { desc = "Step into" })
			Keymap("n", "<F12>", dap.step_out, { desc = "Step out" })
			Keymap("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
			Keymap("n", "<leader>dc", dap.clear_breakpoints, { desc = "Clear Breakpoints" })
		end,
	},
}
