--- Compatible APIs for nvim buffers.
--
--- @author Lin Rongbin (linrongbin16@outlook.com)
--- @copyright MIT
--- @module commons.buffers

local M = {}

--- Get buffer option.
--
-- Get with `bufnr` and option `name`, returns option value.
--
--- @param bufnr integer  (the buffer number)
--- @param name string    (the option name)
--- @return any           (the option value)
M.get_buf_option = function(bufnr, name)
  if vim.fn.has("nvim-0.8") > 0 then
    return vim.api.nvim_get_option_value(name, { buf = bufnr })
  else
    return vim.api.nvim_buf_get_option(bufnr, name)
  end
end

--- Set buffer option.
--
-- Set option to `value`, with `bufnr` and option `name`.
---
--- @param bufnr integer  (the buffer number)
--- @param name string    (the option name)
--- @param value any      (the option value)
--- @return any
M.set_buf_option = function(bufnr, name, value)
  if vim.fn.has("nvim-0.8") > 0 then
    return vim.api.nvim_set_option_value(name, value, { buf = bufnr })
  else
    return vim.api.nvim_buf_set_option(bufnr, name, value)
  end
end

return M
