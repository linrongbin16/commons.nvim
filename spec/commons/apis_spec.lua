local cwd = vim.fn.getcwd()

describe("commons.apis", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
    vim.api.nvim_command("colorscheme darkblue")
  end)

  local apis = require("commons.apis")
  local versions = require("commons.versions")

  local function partial_eq(a, b)
    for k, v in pairs(a) do
      if type(k) == "string" and b[k] ~= v then
        return false
      end
    end
    return true
  end

  describe("[get_buf_option/set_buf_option]", function()
    it("get filetype", function()
      local ft = apis.get_buf_option(0, "filetype")
      print(string.format("filetype get buf option:%s\n", vim.inspect(ft)))
      assert_eq(type(ft), "string")
    end)
    it("set filetype", function()
      apis.set_buf_option(0, "filetype", "lua")
      local ft = apis.get_buf_option(0, "filetype")
      print(string.format("filetype set buf option:%s\n", vim.inspect(ft)))
      assert_eq(ft, "lua")
    end)
  end)

  describe("[get_win_option/set_win_option]", function()
    it("get spell", function()
      apis.set_win_option(0, "spell", true)
      local s = apis.get_win_option(0, "spell")
      print(string.format("spell get win option:%s\n", vim.inspect(s)))
      assert_eq(type(s), "boolean")
      assert_true(s)
    end)
    it("set spell", function()
      apis.set_win_option(0, "spell", false)
      local s = apis.get_win_option(0, "spell")
      print(string.format("spell set win option:%s\n", vim.inspect(s)))
      assert_false(s)
    end)
  end)

  local HIGHLIGHTS_MAP = vim.api.nvim_get_hl(0, {})
  local HIGHLIGHTS = {}
  for hl, _ in pairs(HIGHLIGHTS_MAP) do
    table.insert(HIGHLIGHTS, hl)
  end
  table.sort(HIGHLIGHTS, function(a, b)
    return a < b
  end)

  describe("[dump nvim_get_hl/nvim_get_hl_by_name]", function()
    for hl, _ in pairs(HIGHLIGHTS_MAP) do
      table.insert(HIGHLIGHTS, hl)
    end
    table.sort(HIGHLIGHTS, function(a, b)
      return a < b
    end)
    it("nvim_get_hl", function()
      local fp = io.open("nvim_get_hl.log", "w")
      for i, hl in ipairs(HIGHLIGHTS) do
        local link_payload = vim.api.nvim_get_hl(0, { name = hl })
        local no_link_payload =
          vim.api.nvim_get_hl(0, { name = hl, link = false })
        fp:write(string.format("[%d] %s (link=true):\n", i, vim.inspect(hl)))
        fp:write(string.format("%s\n", vim.inspect(link_payload)))
        fp:write(string.format("[%d] %s (link=false):\n", i, vim.inspect(hl)))
        fp:write(string.format("%s\n", vim.inspect(no_link_payload)))
        fp:write("\n")
      end
      fp:close()
    end)
    it("nvim_get_hl_by_name", function()
      local fp = io.open("nvim_get_hl_by_name_gui.log", "w")
      for i, hl in ipairs(HIGHLIGHTS) do
        local payload = vim.api.nvim_get_hl_by_name(hl, true)
        fp:write(string.format("[%d] %s:\n", i, vim.inspect(hl)))
        fp:write(string.format("%s\n", vim.inspect(payload)))
        fp:write("\n")
      end
      fp:close()
      local fp = io.open("nvim_get_hl_by_name_cterm.log", "w")
      for i, hl in ipairs(HIGHLIGHTS) do
        local payload = vim.api.nvim_get_hl_by_name(hl, false)
        fp:write(string.format("[%d] %s:\n", i, vim.inspect(hl)))
        fp:write(string.format("%s\n", vim.inspect(payload)))
        fp:write("\n")
      end
      fp:close()
    end)
  end)
  describe("[get_hl]", function()
    it("test", function()
      for i, hl in ipairs(HIGHLIGHTS) do
        local hl_values = apis.get_hl(hl)
        assert_eq(type(hl_values), "table")
        assert_true(
          type(hl_values.fg) == "number"
            or hl_values.fg == nil
            or type(hl_values.bg) == "number"
            or hl_values.bg == nil
            or type(hl_values.ctermfg) == "number"
            or hl_values.ctermfg == nil
            or type(hl_values.ctermbg) == "number"
            or hl_values.ctermbg == nil
        )
        assert_true(
          type(hl_values.bold) == "boolean"
            or hl_values.bold == nil
            or type(hl_values.italic) == "boolean"
            or hl_values.italic == nil
            or type(hl_values.underline) == "boolean"
            or hl_values.underline == nil
        )
        if versions.ge({ 0, 9 }) and versions.lt({ 0, 10 }) then
          local gui_values = vim.api.nvim_get_hl_by_name(hl, true)
          local cterm_values = vim.api.nvim_get_hl_by_name(hl, false)
          gui_values.fg = gui_values.foreground
          gui_values.bg = gui_values.background
          gui_values.foreground = nil
          gui_values.background = nil
          local hl_values_gui = vim.deepcopy(hl_values)
          hl_values_gui.ctermfg = nil
          hl_values_gui.ctermbg = nil
          hl_values_gui.cterm = nil
          print(
            string.format(
              "get_hl [%d] hl:%s, gui_values:%s, hl_values_gui:%s\n",
              i,
              vim.inspect(hl),
              vim.inspect(gui_values),
              vim.inspect(hl_values_gui)
            )
          )
          assert_true(partial_eq(hl_values_gui, gui_values))
          cterm_values.fg = cterm_values.foreground
          cterm_values.bg = cterm_values.background
          cterm_values.foreground = nil
          cterm_values.background = nil
          local hl_values_cterm = vim.deepcopy(hl_values.cterm or {})
          hl_values_cterm.fg = hl_values.ctermfg
          hl_values_cterm.bg = hl_values.ctermbg
          print(
            string.format(
              "get_hl [%d] hl:%s, cterm_values:%s, hl_values_cterm:%s\n",
              i,
              vim.inspect(hl),
              vim.inspect(cterm_values),
              vim.inspect(hl_values_cterm)
            )
          )
          assert_true(partial_eq(hl_values_cterm, cterm_values))
        end
      end
    end)
  end)
end)
