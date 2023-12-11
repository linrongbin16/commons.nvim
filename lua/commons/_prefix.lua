--- @alias commons.Configs table<any, any>
--- @type commons.Configs
local Defaults = {
  prefix = "",
}

--- @type commons.Configs
local Configs = {}

local M = {}

M.prefix = function()
  return Configs
end

--- @param opts commons.Configs?
M.setup = function(opts)
  Configs = vim.tbl_deep_extend("force", Defaults, opts or {})
end

return M
