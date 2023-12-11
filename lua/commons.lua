local M = {}

local Defaults = {
  module_prefix = nil,
}

local Configs = {}

M.setup = function()
  local base_dir = vim.fn["commons#nvim#base_dir"]()
end

return M
