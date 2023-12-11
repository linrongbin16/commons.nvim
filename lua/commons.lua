local M = {}

local Defaults = {
  module_prefix = nil,
}

local Configs = {}

--- @alias commons.Options table<any, any>
--- @param opts commons.Options?
M.setup = function(opts)
  if
    type(opts) == "table"
    and type(opts.module_prefix) == "string"
    and string.len(opts.module_prefix) > 0
  then
    local prefix = opts.module_prefix
    if string.sub(prefix, #prefix) ~= "." then
      prefix = prefix .. "."
    end
    vim.env._COMMONS_NVIM_MODULE_PREFIX = prefix
  end
end

return M
