local M = {}

function M.pick_old()
  local oldfiles = vim.v.oldfiles
  if #oldfiles == 0 then
    print("No recent files found")
    return
  end

  local home = vim.fn.expand("~")
  local display_files = {}
  local file_map = {}

  for _, f in ipairs(oldfiles) do
    local display = f

    if f:sub(1, #home) == home then
      display = f:sub(#home + 1)
      if display:sub(1,1) == "/" then
        display = display:sub(2)
      end
    else
      if display:sub(1,1) == "/" then
        display = display:sub(2)
      end
    end

    display = " " .. display
    table.insert(display_files, display)
    file_map[display] = f
  end

  vim.ui.select(display_files, {
    prompt = "Pick a recent file:",
  }, function(choice)
    if choice then
      vim.cmd("edit " .. vim.fn.fnameescape(file_map[choice]))
    end
  end)
end

vim.api.nvim_create_user_command("PickOld", function()
  M.pick_old()
end, {})

return M

