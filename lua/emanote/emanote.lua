local Path = require("plenary/path")
local uv = vim.loop

local M = {}

function M.sayHelloWorld() print('Hello world!') end

function buildParents(path, sep)


    print(path)
    path = vim.fn.expand(path)

    if sep == nil then
      sep = "/"
    end

    local full_path = ""
    for parent in string.gmatch(path, "([^"..sep.."]+)") do

      full_path = full_path .. "/" .. parent

      full_path = vim.fn.expand(full_path)

      if vim.fn.isdirectory(full_path) == 0 then

        print("=====")
        print(full_path)
        print(path)
        print(full_path ~= path)
        if full_path ~= path then
          vim.fn.mkdir(full_path)
        end
      end

    end
end

-- Function to create new note
local function createNewNote(name)

  -- config_path = "~/personal/kb"
  config_path = "~/personal/kb"
  full_path = config_path .. "/" .. name
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

return M
