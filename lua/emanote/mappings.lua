local emanote = require("emanote")

local M = {}

function M.map(key, rhs)
  local lhs = string.format("%s%s", emanote.config.leader, key)
  vim.api.nvim_set_keymap("n", lhs, rhs, {noremap = true, silent = true})
end

function M.set_mappings()
  M.map("n", "<cmd>lua require('emanote').newNote()<CR>")
end

return M
