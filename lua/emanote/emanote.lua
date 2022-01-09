local Path = require("plenary/path")
local uv = vim.loop

local M = {}

function M.sayHelloWorld() print('Hello world!') end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

-- Function to create new note
local function createNewNote(name)

  config_path = "~/personal/kb"
  exec = ":e " .. config_path .. "/" .. name
  vim.api.nvim_exec(exec, 0)

end

function M.newNote() 
  
  -- createFloatingInput()
  vim.ui.input({
    prompt="Name of New Note:"
  }, function(name) createNewNote(name) end) 

end

return M
