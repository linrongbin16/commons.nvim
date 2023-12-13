-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/home/runner/work/commons.nvim/commons.nvim/.luarocks" };
}
lua_interpreter = "lua";
variables = {
   LUA_DIR = "/home/runner/work/commons.nvim/commons.nvim/.lua";
   LUA_BINDIR = "/home/runner/work/commons.nvim/commons.nvim/.lua/bin";
}
