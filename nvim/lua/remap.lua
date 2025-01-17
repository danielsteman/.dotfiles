vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- remap to copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- remap to paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>P", '"+P')

-- remap to run python script
vim.keymap.set("n", "<F4>", ":w <bar> exec '!python3 '.shellescape('%')<CR>")

-- remap to scroll 15 lines down and up
vim.keymap.set("n", "<C-j>", "15j", { desc = "Scroll down 15 lines" })
vim.keymap.set("n", "<C-k>", "15k", { desc = "Scroll up 15 lines" })
