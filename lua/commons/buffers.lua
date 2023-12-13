-- Compatible Neovim APIs relate to nvim buffers.
--
-- Author: Lin Rongbin (linrongbin16@outlook.com)
-- Copyright: MIT

local M = {}

-- Get buffer option with `bufnr` and option `name`, returns option value.
--
--- @param bufnr integer  buffer number
--- @param name string    option name
--- @return any           option value
M.get_buf_option = function(bufnr, name)
  if vim.fn.has("nvim-0.8") > 0 then
    return vim.api.nvim_get_option_value(name, { buf = bufnr })
  else
    return vim.api.nvim_buf_get_option(bufnr, name)
  end
end

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
