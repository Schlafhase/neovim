return {
	{
		"LuaSnip",
		dep_of = { "blink.cmp" },
		after = function()
			local ls = require("luasnip")

			Keymap({ "i", "s" }, "<C-A>", function()
				ls.jump(1)
			end, { silent = true })
			Keymap({ "i", "s" }, "<C-Q>", function()
				ls.jump(-1)
			end, { silent = true })

			local s, t, i = ls.snippet, ls.text_node, ls.insert_node
			ls.add_snippets("cs", {
				s("ctor", {
					t("public "),
					i(1),
					t("("),
					i(2),
					t({ ")", "{", "  " }),
					i(3),
					t({ "", "}" }),
				}),
			})
		end,
	},
}
