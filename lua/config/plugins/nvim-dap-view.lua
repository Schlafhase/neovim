return {
	{
		"nvim-dap-view",
		lazy = false,
		setup = {
			winbar = {
				show = true,
				sections = { "scopes", "console", "watches", "exceptions", "breakpoints", "repl" },
				default_section = "scopes",
				show_keymap_hints = false,
				base_sections = {
					breakpoints = { label = "[B]reakpoints", keymap = "B" },
					scopes = { label = "[S]copes", keymap = "S" },
					exceptions = { label = "[E]xceptions", keymap = "E" },
					watches = { label = "[W]atches", keymap = "W" },
					threads = { label = "[T]hreads", keymap = "T" },
					repl = { label = "[R]EPL", keymap = "R" },
					sessions = { label = "Sess[I]ons", keymap = "I" },
					console = { label = "[C]onsole", keymap = "C" },
				},
			},
			virtual_text = {
				enabled = true,
			},
		},
		after = function()
			local dap = require("dap")
			local dap_view = require("dap-view")

			dap.listeners.after.event_initialized["nvim-dap-view-open"] = function()
				dap_view.open()
			end

			dap.listeners.before.event_terminated["nvim-dap-view-open"] = function()
				dap_view.close()
			end
		end,
	},
}
