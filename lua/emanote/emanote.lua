
local M = {}

function M.sayHelloWorld() print('Hello world!') end

-- Function to create new note
local function createNewNote(name)
  print(name)
end

function M.newNote() 
  
  -- createFloatingInput()
  vim.ui.input({
    prompt="Name of New Note:"
  }, function(name) createNewNote(name) end) 

end

return M
