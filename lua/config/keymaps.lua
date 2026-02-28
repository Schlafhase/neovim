-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

vim.keymap.set({ "n", "t", "v", "i" }, "<C-h>", "<C-W>h", { desc = "Go to left window" })
vim.keymap.set({ "n", "t", "v", "i" }, "<C-j>", "<C-W>j", { desc = "Go to bottom window" })
vim.keymap.set({ "n", "t", "v", "i" }, "<C-k>", "<C-W>k", { desc = "Go to top window" })
vim.keymap.set({ "n", "t", "v", "i" }, "<C-l>", "<C-W>l", { desc = "Go to right window" })
vim.keymap.set({ "n" }, "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })

vim.keymap.set("i", "<M-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Moves Line Down" })
vim.keymap.set("n", "<M-j>", "<Cmd>execute 'move .+' . v:count1<CR>==", { desc = "Moves Line Down" })
vim.keymap.set("v", "<M-j>", "<Cmd><C-U>execute \"'<lt>,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Moves Line Down" })
vim.keymap.set("i", "<M-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Moves Line Up" })
vim.keymap.set("n", "<M-k>", "<Cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Moves Line Up" })
vim.keymap.set(
	"v",
	"<M-k>",
	"<Cmd><C-U>execute \"'<lt>,'>move '<lt>-\" . (v:count1 + 1)<CR>gv=gv",
	{ desc = "Moves Line Up" }
)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })

vim.keymap.set("n", "H", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader><leader>l", "<cmd>b#<CR>", { desc = "Last buffer" })
vim.keymap.set("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = "delete buffer" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "Open LSP hover" })
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open diagnostics list" })

-- kickstart.nvim starts you with this.
-- But it constantly clobbers your system clipboard whenever you delete anything.
-- It syncs clipboard between OS and Neovim.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- You should instead use these keybindings so that they are still easy to use, but dont conflict
vim.keymap.set({ "v", "x", "n" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.keymap.set(
	{ "n", "v", "x" },
	"<leader>Y",
	'"+yy',
	{ noremap = true, silent = true, desc = "Yank line to clipboard" }
)
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set(
	"i",
	"<C-p>",
	"<C-r><C-p>+",
	{ noremap = true, silent = true, desc = "Paste from clipboard from within insert mode" }
)
vim.keymap.set(
	"x",
	"<leader>P",
	'"_dP',
	{ noremap = true, silent = true, desc = "Paste over selection without erasing unnamed register" }
)

vim.keymap.set({ "n", "v", "i" }, "<S-TAB>", function()
	require("telescope.builtin").buffers({ sort_mru = true, sort_lastused = true })
end)

vim.keymap.set("n", "<leader>n", "<cmd>Noice telescope<CR>", { desc = "Show Notifications" })
