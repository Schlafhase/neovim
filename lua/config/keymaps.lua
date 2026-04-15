Keymap = vim.keymap.set

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help Keymap()`

Keymap({ "n", "t", "v", "i" }, "<C-h>", "<C-W>h", { desc = "Go to left window" })
Keymap({ "n", "t", "v", "i" }, "<C-j>", "<C-W>j", { desc = "Go to bottom window" })
Keymap({ "n", "t", "v", "i" }, "<C-k>", "<C-W>k", { desc = "Go to top window" })
Keymap({ "n", "t", "v", "i" }, "<C-l>", "<C-W>l", { desc = "Go to right window" })
Keymap({ "n" }, "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })

-- Keymap("i", "<M-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Moves Line Down" })
-- Keymap("n", "<M-j>", "<Cmd>execute 'move .+' . v:count1<CR>==", { desc = "Moves Line Down" })
-- Keymap("v", "<M-j>", "<Cmd><C-U>execute \"'<lt>,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Moves Line Down" })
-- Keymap("i", "<M-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Moves Line Up" })
-- Keymap("n", "<M-k>", "<Cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Moves Line Up" })
-- Keymap(
-- 	"v",
-- 	"<M-k>",
-- 	"<Cmd><C-U>execute \"'<lt>,'>move '<lt>-\" . (v:count1 + 1)<CR>gv=gv",
-- 	{ desc = "Moves Line Up" }
-- )

Keymap("n", "n", "nzzzv", { desc = "Next Search Result" })
Keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
Keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
Keymap("n", "N", "Nzzzv", { desc = "Previous Search Result" })

Keymap("n", "H", "<cmd>bprev<CR>", { desc = "Previous buffer" })
Keymap("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- Keymap("n", "<leader><leader>l", "<cmd>b#<CR>", { desc = "Last buffer" })
-- Keymap("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = "delete buffer" })

-- Remap for dealing with word wrap
Keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
Keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
Keymap("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "Open LSP hover" })
Keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open diagnostics list" })

vim.o.clipboard = "unnamedplus"

-- Keymap({ "v", "x", "n" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
-- Keymap({ "n", "v", "x" }, "<leader>Y", '"+yy', { noremap = true, silent = true, desc = "Yank line to clipboard" })
-- Keymap({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
Keymap(
	"i",
	"<C-p>",
	"<C-r><C-p>+",
	{ noremap = true, silent = true, desc = "Paste from clipboard from within insert mode" }
)
Keymap(
	"x",
	"<leader>P",
	'"_dP',
	{ noremap = true, silent = true, desc = "Paste over selection without erasing unnamed register" }
)

Keymap("n", "<leader>n", "<cmd>Telescope notify<CR>", { desc = "Show Notifications" })

Keymap("n", "<leader>pu", vim.pack.update, { desc = "Update all plugins" })
