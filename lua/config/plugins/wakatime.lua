return {
	{
		"vim-wakatime",
		event = "BufEnter",
		enabled = function()
			local cfg = vim.fn.expand("~/.wakatime.cfg")
			local f = io.open(cfg, "r")
			if not f then
				return false
			end
			for line in f:lines() do
				if line:match("^%s*api_key%s*=") or line:match("^%s*api_key_vault_cmd%s*=") then
					f:close()
					return true
				end
			end
			f:close()
			return false
		end,
	},
}
