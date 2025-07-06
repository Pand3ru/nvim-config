local opts = {
    noremap = true,
    silent = true,
}

local k = vim.keymap.set

---------
-- normal
---------

-- window jumping
k('n', '<C-h>', '<C-w>h', opts)
k('n', '<C-j>', '<C-w>j', opts)
k('n', '<C-k>', '<C-w>k', opts)
k('n', '<C-l>', '<C-w>l', opts)

-- window resizing
k('n', '<C-Up>', ':resize -2<CR>', opts)
k('n', '<C-Down>', ':resize +2<CR>', opts)
k('n', '<C-Left>', ':vertical resize +2<CR>', opts)
k('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-- nav
k('n', 'J', '<C-D>', opts)
k('n', 'K', '<C-U>', opts)
k('n', 'U', '<C-R>', opts)

k('n', '<Right>', ':tabn<CR>', opts)
k('n', '<Left>', ':tabp<CR>', opts)

k('n', '<C-F>', function()
  local builtin = require('telescope.builtin')
  local ok = pcall(builtin.git_files)
  if not ok then
    builtin.find_files()
  end
end, opts)

k('n', '<C-SPACE>', function() require('telescope.builtin').oldfiles() end, opts)

---------
-- insert
---------

k('i', 'kj', '<ESC>', opts)

---------
-- visual
---------
