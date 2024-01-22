local cwd = vim.fn.getcwd()

describe("commons.apis", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local apis = require("commons.apis")

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

  describe("[dump nvim_get_hl/nvim_get_hl_by_name]", function()
    local HL_MAP = vim.api.nvim_get_hl(0, {})
    local ALL_HL = {}
    for hl, _ in pairs(HL_MAP) do
      table.insert(ALL_HL, hl)
    end
    table.sort(ALL_HL, function(a, b)
      return a < b
    end)
    it("nvim_get_hl", function()
      local fp = io.open("nvim_get_hl.log", "w")
      for i, hl in ipairs(ALL_HL) do
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
      for i, hl in ipairs(ALL_HL) do
        local payload = vim.api.nvim_get_hl_by_name(hl, true)
        fp:write(string.format("[%d] %s:\n", i, vim.inspect(hl)))
        fp:write(string.format("%s\n", vim.inspect(payload)))
        fp:write("\n")
      end
      fp:close()
      local fp = io.open("nvim_get_hl_by_name_cterm.log", "w")
      for i, hl in ipairs(ALL_HL) do
        local payload = vim.api.nvim_get_hl_by_name(hl, false)
        fp:write(string.format("[%d] %s:\n", i, vim.inspect(hl)))
        fp:write(string.format("%s\n", vim.inspect(payload)))
        fp:write("\n")
      end
      fp:close()
    end)
  end)
  describe("[get_hl]", function()
    local HL = {
      "Special",
      "Normal",
      "LineNr",
      "TabLine",
      "Exception",
      "Comment",
      "Label",
      "String",
    }
    it("test", function()
      for i, hl in ipairs(HL) do
        local hlvalues = apis.get_hl(hl)
        assert_eq(type(hlvalues), "table")
        assert_true(
          type(hlvalues.fg) == "number"
            or hlvalues.fg == nil
            or type(hlvalues.bg) == "number"
            or hlvalues.bg == nil
            or type(hlvalues.ctermfg) == "number"
            or hlvalues.ctermfg == nil
            or type(hlvalues.ctermbg) == "number"
            or hlvalues.ctermbg == nil
        )
        assert_true(
          type(hlvalues.bold) == "boolean"
            or hlvalues.bold == nil
            or type(hlvalues.italic) == "boolean"
            or hlvalues.italic == nil
            or type(hlvalues.underline) == "boolean"
            or hlvalues.underline == nil
        )
      end
    end)
  end)
end)
