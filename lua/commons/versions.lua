local HAS_VIM_VERSION = vim.is_callable(vim.version)
local HAS_VIM_VERSION_EQ = HAS_VIM_VERSION
  and type(vim.version) == "table"
  and vim.is_callable(vim.version.eq)
local HAS_VIM_VERSION_GT = HAS_VIM_VERSION
  and type(vim.version) == "table"
  and vim.is_callable(vim.version.gt)
local HAS_VIM_VERSION_GE = HAS_VIM_VERSION
  and type(vim.version) == "table"
  and vim.is_callable(vim.version.ge)
local HAS_VIM_VERSION_LT = HAS_VIM_VERSION
  and type(vim.version) == "table"
  and vim.is_callable(vim.version.lt)
local HAS_VIM_VERSION_LE = HAS_VIM_VERSION
  and type(vim.version) == "table"
  and vim.is_callable(vim.version.le)

local M = {}

--- @param l integer[]
--- @return string
M.to_string = function(l)
  assert(type(l) == "table")
  local builder = {}
  for _, v in ipairs(l) do
    table.insert(builder, tostring(v))
  end
  return table.concat(builder, ".")
end

--- @param s string
--- @return integer[]
M.to_list = function(s)
  assert(type(s) == "string")
  local splits = vim.split(s, ".", { plain = true })
  local result = {}
  for _, v in ipairs(splits) do
    table.insert(result, tonumber(v))
  end
  return result
end

--- @param ver string|string[]
--- @return boolean
M.lt = function(ver)
  if HAS_VIM_VERSION and HAS_VIM_VERSION_LT then
    if type(ver) == "string" then
      ver = M.to_list(ver)
    end
    return vim.version.lt(vim.version(), ver)
  else
    if type(ver) == "table" then
      ver = M.to_string(ver)
    end
    ver = "nvim-" .. ver
    return vim.fn.has(ver) < 1
  end
end

--- @param ver string|string[]
--- @return boolean
M.ge = function(ver)
  if HAS_VIM_VERSION and HAS_VIM_VERSION_EQ and HAS_VIM_VERSION_GT then
    if type(ver) == "string" then
      ver = M.to_list(ver)
    end
    return vim.version.gt(vim.version(), ver)
      or vim.version.eq(vim.version(), ver)
  elseif HAS_VIM_VERSION and HAS_VIM_VERSION_GE then
    if type(ver) == "string" then
      ver = M.to_list(ver)
    end
    return vim.version.ge(vim.version(), ver)
  else
    if type(ver) == "table" then
      ver = M.to_string(ver)
    end
    ver = "nvim-" .. ver
    return vim.fn.has(ver) > 0
  end
end

return M
