local cwd = vim.fn.getcwd()

describe("commons.colors.hl", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
    vim.api.nvim_command("colorscheme darkblue")
  end)

  local hl_colors = require("commons.colors.hl")
  local strings = require("commons.strings")
  local versions = require("commons.versions")

  describe("[get_color]", function()
    it("test", function()
      local hl_with_fallback = { "NotExistHl", "@comment", "Comment" }
      local actual1 = hl_colors.get_color("Comment", "fg")
      local actual2 = hl_colors.get_color("Constant", "fg")
      local actual3 = hl_colors.get_color("Visual", "bg")
      if actual1 then
        assert_eq(type(actual1), "string")
        assert_true(strings.startswith(actual1, "#"))
        assert_eq(#actual1, 7)
      end
      if actual2 then
        assert_eq(type(actual2), "string")
        assert_true(strings.startswith(actual2, "#"))
        assert_eq(#actual2, 7)
      end
      if actual3 then
        assert_eq(type(actual3), "string")
        assert_true(strings.startswith(actual3, "#"))
        assert_eq(#actual3, 7)
      end
    end)
  end)
  describe("[get_color_with_fallback]", function()
    it("test", function()
      local input1 = { "NotExistHl" }
      local actual11, actual12, actual13 =
        hl_colors.get_color_with_fallback(input1, "fg", "#123456")
      assert_eq(actual11, "#123456")
      assert_eq(actual12, -1)
      assert_eq(actual13, nil)

      local input2 = { "NotExistHl" }
      local actual21, actual22, actual23 =
        hl_colors.get_color_with_fallback(input2, "bg")
      assert_eq(actual21, nil)
      assert_eq(actual22, -1)
      assert_eq(actual23, nil)

      local actual3 = hl_colors.get_color_with_fallback(
        { "Constant", "Visual" },
        "fg",
        "#123456"
      )
      if actual3 then
        assert_eq(type(actual3), "string")
        assert_true(strings.startswith(actual3, "#"))
        assert_eq(#actual3, 7)

        local expect3 = versions.ge("0.9")
            and vim.api.nvim_get_hl(0, { name = "Constant", link = false })
          or vim.api.nvim_get_hl_by_name("Constant", true)
        assert_eq(
          string.format("#%06x", expect3.foreground or expect3.fg),
          actual3
        )
      end

      local actual4 =
        hl_colors.get_color_with_fallback("Visual", "bg", "#123456")
      if actual4 then
        assert_eq(type(actual4), "string")
        assert_true(strings.startswith(actual4, "#"))
        assert_eq(#actual4, 7)
        assert_true(actual4 ~= "#123456")
      end
    end)
  end)
end)
