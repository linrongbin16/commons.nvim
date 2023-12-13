--- @author Lin Rongbin (linrongbin16@outlook.com)
--- @copyright MIT

-- Compatible APIs for nvim buffers.

local M = {}

--- Get buffer option.
-- Get option value by `bufnr` and option `name`, returns option value.
--
--- @param bufnr integer
--- @param name string
--- @return any
M.get_buf_option = function(bufnr, name)
  if vim.fn.has("nvim-0.8") > 0 then
    return vim.api.nvim_get_option_value(name, { buf = bufnr })
  else
    return vim.api.nvim_buf_get_option(bufnr, name)
  end
end

--- Set buffer option.
-- Set option value to `value`, by `bufnr` and option `name`.
---
--- @param bufnr integer
--- @param name string
--- @param value any
--- @return any
M.set_buf_option = function(bufnr, name, value)
  if vim.fn.has("nvim-0.8") > 0 then
    return vim.api.nvim_set_option_value(name, value, { buf = bufnr })
  else
    return vim.api.nvim_buf_set_option(bufnr, name, value)
  end
end

return M
