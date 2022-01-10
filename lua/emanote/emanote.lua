local Path = require("plenary/path")
local Job = require("plenary/job")
local uv = vim.loop

local M = {}

function M.printPath() print(M.config.emanote_home) end

function buildParents(path, sep)

    path = vim.fn.expand(path)

    if sep == nil then
      sep = "/"
    end

    local full_path = ""
    for parent in string.gmatch(path, "([^"..sep.."]+)") do

      full_path = full_path .. "/" .. parent

      full_path = vim.fn.expand(full_path)

      if vim.fn.isdirectory(full_path) == 0 then
        if full_path ~= path then
          vim.fn.mkdir(full_path)
        end
      end

    end
end


-- Function to create new note
local function createNewNote(name)

  -- config_path = "~/personal/kb"
  full_path = M.config.emanote_home .. "/" .. name
  exec = ":e " .. full_path

  buildParents(full_path)

  vim.api.nvim_exec(exec, 0)
  vim.api.nvim_exec(":w", 0)

end

function M.newNote() 
  
  -- createFloatingInput()
  vim.ui.input({
    prompt="Name of New Note:"
  }, function(name) createNewNote(name) end) 

end

-- Launch Server Functionality
-- 

function M.killServer()

  print("Killing All Running Emanote Servers...")
  vim.api.nvim_exec("!{pid=$(pgrep emanote) && kill $pid}", 1)

end

function M.launchServer()
  
  emanote_host = "localhost"
  emanote_port = "8000"

  M.killServer()

  print("Launching Emanote Server @ http://"..emanote_host..":"..emanote_port)

  Job:new({
    command = 'emanote',
    cwd = M.config.emanote_home
  }):start()

end 


do

  local default_config = {
    emanote_home = "~/emanote",
    leader = "g"
  }

  function M.setup(user_config)
    
    -- Check if Emanote is Executable in Path
    if vim.fn.executable("emanote") == 0 then
      error("emanote is not executable.")
    end

    -- Manage Config
    user_config = user_config or {}
    M.config = vim.tbl_extend("keep", user_config, default_config)

    -- Transform Config if Needed
    M.config.emanote_dir = vim.fn.expand(M.config.emanote_dir)
  end

end


return M
