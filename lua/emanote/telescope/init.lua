local emanote = require("emanote.emanote")

local M = {}

function M.findNotes()

  local find_opts = { prompt_title="Find Notes",
    search_dirs={emanote.config.emanote_home},
    path_display={"tail"}
  }

  vim.api.nvim_exec(":Telescope <esc>", 0)
  require("telescope.builtin").find_files(find_opts)

end

function M.grepNotes()

  local find_opts = {prompt_title="Grep Notes",
    search_dirs={emanote.config.emanote_home}
  }

  vim.api.nvim_exec(":Telescope <esc>", 0)
  require("telescope.builtin").live_grep(find_opts)

end

return M

