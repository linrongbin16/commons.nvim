local cwd = vim.fn.getcwd()

describe("commons.termcolors", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

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
    local function test_render(msg, result)
      print(msg)
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
        local actual = termcolors.render("fg", color, hl)
        test_render(
          string.format("fg(%s): %s\n", hl, vim.inspect(actual)),
          actual
        )
      end
    end)
    it("bg", function()
      for color, hl in pairs(TEST_CASES) do
        local actual = termcolors.render("bg", color, hl)
        test_render(
          string.format("bg(%s): %s\n", hl, vim.inspect(actual)),
          actual
        )
      end
    end)
  end)
  describe("[erase]", function()
    it("no change", function()
      assert_eq("hello world", termcolors.unescape("hello world"))
      assert_eq("let's go", termcolors.unescape("let's go"))
    end)
    it("erase", function()
      assert_eq(
        "hello world",
        termcolors.unescape("\x1b[38mhello world\x1b[0m")
      )
      assert_eq("let's go", termcolors.unescape("\x1b[38mlet's go\x1b[0m"))
    end)
  end)
end)
