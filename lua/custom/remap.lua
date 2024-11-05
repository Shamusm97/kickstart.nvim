vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })

-- map Alt-left and Alt-right to move between tabs
vim.keymap.set("n", "<M-Left>", "<cmd>tabprevious<CR>", {desc = "Move to previous tab"})
vim.keymap.set("n", "<M-h>", "<cmd>tabprevious<CR>", {desc = "Move to previous tab"})
vim.keymap.set("n", "<M-Right>", "<cmd>tabnext<CR>", {desc = "Move to next tab"})
vim.keymap.set("n", "<M-l>", "<cmd>tabnext<CR>", {desc = "Move to next tab"})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move line down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Move line up"})

vim.keymap.set("n", "J", "mzJ`z", {desc = "Join line below to the current one (keep cursor location"})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = "Scroll down and center cursor"})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = "Scroll up and center cursor"})
vim.keymap.set("n", "n", "nzzzv", {desc = "Move to next match, opening folds"})
vim.keymap.set("n", "N", "Nzzzv", {desc = "Move to previous match, opening folds"})

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], {desc = "Paste without overwriting paste buffer"})

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], {desc = "Yank to system clipboard"})
vim.keymap.set("n", "<leader>Y", [["+Y]], {desc = "Yank line to system clipboard"})

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], {desc = "Delete without trashing clipboard"})

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", {desc = "Escape insert mode"})

vim.keymap.set("n", "Q", "<nop>", {desc = "Remap Q to no operation"})
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer with LSP" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Goto next item in quickfix list"})
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", {desc = "Goto previous item in quickfix list"})
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", {desc = "Goto next item in location list"})
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", {desc = "Goto previous item in location list"})

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Globally search and replace word under cursor"})
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make the current file executable" })

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
