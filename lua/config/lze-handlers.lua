lze.register_handlers({
	{
		spec_field = "setup",
		set_lazy = false,
		modify = function(plugin)
			if plugin.setup ~= nil then
				local opts = plugin.setup
				local mod = plugin.setup_module or plugin.name
				local prev_after = plugin.after
				plugin.after = function(p)
					local candidates = {
						mod,
						mod:gsub("%.nvim$", ""),
						mod:gsub("^nvim%-", ""),
						mod:gsub("^nvim%-", ""):gsub("%.nvim$", ""),
						mod:gsub("%.vim$", ""),
						mod:gsub("^vim%-", ""),
						mod:gsub("^vim%-", ""):gsub("%.vim$", ""),
						mod:gsub("^vim%-", ""):gsub("%.nvim$", ""),
						mod:gsub("^vimplugin%-", ""),
						mod:gsub("^vimplugin%-", ""):gsub("%.nvim$", ""),
					}
					local pluginModule
					for _, candidate in ipairs(candidates) do
						local ok, result = pcall(require, candidate)
						if ok then
							pluginModule = result
							break
						end
					end
					if pluginModule then
						pcall(pluginModule.setup, opts)
					end

					if prev_after then
						prev_after(p)
					end
				end
			end
			return plugin
		end,
	},
	-- From lzextras. This one makes it so that
	-- you can set up lsps within lze specs,
	-- and trigger lspconfig setup hooks only on the correct filetypes
	-- It is (unfortunately) important that it be registered after the above 2,
	-- as it also relies on the modify hook, and the value of enabled at that point
	lzextras.lsp,
})
