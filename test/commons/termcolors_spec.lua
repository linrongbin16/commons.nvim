local cwd = vim.fn.getcwd()

describe("commons.termcolors", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local termcolors = require("commons.termcolors")
  describe("[retrieve]", function()
    local TEST_CASES = {
      "Special",
      "Normal",
      "LineNr",
      "TabLine",
      "Exception",
      "Comment",
      "Label",
      "String",
    }
    it("fg", function()
      for _, hl in ipairs(TEST_CASES) do
        local actual = termcolors.retrieve("fg", hl)
        print(string.format("hlcode(%s): %s\n", hl, vim.inspect(actual)))
        assert_true(type(actual) == "string" or actual == nil)
        if type(actual) == "string" then
          assert_true(tonumber(actual) >= 0)
        end
      end
    end)
    it("bg", function()
      for _, hl in ipairs(TEST_CASES) do
        local actual = termcolors.retrieve("bg", hl)
        print(string.format("hlcode(%s): %s\n", hl, vim.inspect(actual)))
        assert_true(type(actual) == "string" or actual == nil)
        if type(actual) == "string" then
          assert_true(tonumber(actual) >= 0)
        end
      end
    end)
  end)

  describe("[render]", function()
    local TEST_CASES = {
      black = "Comment",
      grey = "Comment",
      silver = "Comment",
      white = "Comment",
      red = "Exception",
      magenta = "Special",
      fuchsia = "Special",
      purple = "Special",
      yellow = "LineNr",
      orange = "LineNr",
      olive = "LineNr",
      green = "Label",
      lime = "Label",
      teal = "Label",
      cyan = "String",
      aqua = "String",
      blue = "TabLine",
      navy = "TabLine",
    }
    -- see: https://stackoverflow.com/a/55324681/4438921
    local function test_render(result)
      assert_eq(type(result), "string")
      assert_true(string.len(result) > 0)
      local i0, j0 = result:find("\x1b%[0m")
      assert_true(i0 > 1)
      assert_true(j0 > 1)
      local i1, j1 = result:find("\x1b%[%d+m")
      assert_true(i1 >= 1)
      assert_true(j1 >= 1)
      local i2, j2 = result:find("\x1b%[%d+;%d+m")
      if i2 ~= nil and j2 ~= nil then
        assert_true(i2 >= 1)
        assert_true(j2 >= 1)
        assert_true(i2 < i0)
        assert_true(j2 < j0)
      end
      local i3, j3 = result:find("\x1b%[%d+;%d+;%d+m")
      if i3 ~= nil and j3 ~= nil then
        assert_true(i3 >= 1)
        assert_true(j3 >= 1)
        assert_true(i3 < i0)
        assert_true(j3 < j0)
      end
      local i4, j4 = result:find("\x1b%[%d+;%d+;%d+;%d+m")
      if i4 ~= nil and j4 ~= nil then
        assert_true(i4 >= 1)
        assert_true(j4 >= 1)
        assert_true(i4 < i0)
        assert_true(j4 < j0)
      end
    end

    it("fg", function()
      for color, hl in pairs(TEST_CASES) do
        print(string.format("fg-1: %s-%s\n", color, hl))
        local actual = termcolors.render("fg", color, hl)
        print(
          string.format("fg-2(%s-%s): %s\n", color, hl, vim.inspect(actual))
        )
        test_render(actual)
      end
    end)
    it("bg", function()
      for color, hl in pairs(TEST_CASES) do
        print(string.format("bg-1: %s-%s\n", color, hl))
        local actual = termcolors.render("bg", color, hl)
        print(
          string.format("bg-2(%s-%s): %s\n", color, hl, vim.inspect(actual))
        )
        test_render(actual)
      end
    end)
    it("print builtin", function()
      print(
        "builtin-1 grey:" .. termcolors.render("Grey Color", "grey") .. "\n"
      )
      print(
        "builtin-2 magenta:"
          .. termcolors.render("Magenta Color", "magenta")
          .. "\n"
      )
      print(
        "builtin-3 chocolate:"
          .. termcolors.render("Chocolate Color", "chocolate")
          .. "\n"
      )
      print(
        "builtin-4 teal:" .. termcolors.render("Teal Color", "teal") .. "\n"
      )
    end)
    it("print RGB", function()
      print(
        "RGB-1 #808080:" .. termcolors.render("Grey Color", "#808080") .. "\n"
      )
      print(
        "RGB-2 fuchsia:"
          .. termcolors.render("Fuchsia Color", "#FF00FF")
          .. "\n"
      )
      print(
        "RGB-3 olive:" .. termcolors.render("Olive Color", "#808000") .. "\n"
      )
    end)
  end)
  describe("[erase]", function()
    it("no change", function()
      assert_eq("hello world", termcolors.erase("hello world"))
      assert_eq("let's go", termcolors.erase("let's go"))
    end)
    it("erase", function()
      assert_eq("hello world", termcolors.erase("\x1b[38mhello world\x1b[0m"))
      assert_eq("let's go", termcolors.erase("\x1b[38mlet's go\x1b[0m"))
      assert_eq("let's go", termcolors.erase("\x1b[38mlet's go\x1b[m"))
    end)
  end)
end)
