local ok, c_ext = pcall(require, "bit")
if ok then
  return c_ext
end
  
return require("commons._bitop").bit
