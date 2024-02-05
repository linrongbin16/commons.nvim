local M = {}

--- @param highlights string|string[]
--- @param attr "fg"|"bg"|"sp"
--- @param fallback_color string?
--- @return string?, integer, string?
M.get_color_with_fallback = function(highlights, attr, fallback_color)
  assert(type(highlights) == "string" or type(highlights) == "table")
  assert(attr == "fg" or attr == "bg" or attr == "sp")
  local hls = type(highlights) == "string" and { highlights } or highlights --[[@as table]]
  local get_hl = require("commons.apis").get_hl

  for i, hl in ipairs(hls) do
    local hl_value = get_hl(hl)
    if type(hl_value) == "table" and type(hl_value[attr]) == "number" then
      return string.format("#%06x", hl_value[attr]), i, hl
    end
  end

  return fallback_color, -1, nil
end
