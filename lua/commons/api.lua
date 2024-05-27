---@diagnostic disable: deprecated

local M = {}

--- @param ... string?
--- @return {fg:integer?,bg:integer?,[string]:any,ctermfg:integer?,ctermbg:integer?,cterm:{fg:integer?,bg:integer?,[string]:any}?}, integer, string?
M.get_hl_with_fallback = function(...)
  for i, hl in ipairs({ ... }) do
    if type(hl) == "string" then
      local hl_value = M.get_hl(hl)
      if type(hl_value) == "table" and not vim.tbl_isempty(hl_value) then
        return hl_value, i, hl
      end
    end
  end

  return vim.empty_dict(), -1, nil
end

-- highlight }

return M
