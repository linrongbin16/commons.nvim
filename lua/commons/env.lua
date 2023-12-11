local M = {}

--- @return string
M._module_prefix = function()
  return vim.env._COMMONS_NVIM_MODULE_PREFIX or ""
end

return M
