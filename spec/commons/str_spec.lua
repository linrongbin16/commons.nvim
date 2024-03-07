local cwd = vim.fn.getcwd()

describe("commons.str", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local str = require("commons.str")

  describe("[empty/not_empty/blank/not_blank]", function()
    it("empty", function()
      assert_true(str.empty())
      assert_true(str.empty(nil))
      assert_true(str.empty(""))
      assert_false(str.not_empty())
      assert_false(str.not_empty(nil))
      assert_false(str.not_empty(""))
    end)
    it("not empty", function()
      assert_true(str.not_empty(" "))
      assert_true(str.not_empty(" asdf "))
      assert_false(str.empty(" "))
      assert_false(str.empty(" asdf "))
    end)
    it("blank", function()
      assert_true(str.blank())
      assert_true(str.blank(nil))
      assert_true(str.blank(" "))
      assert_true(str.blank("\n"))
      assert_false(str.not_blank())
      assert_false(str.not_blank(nil))
      assert_false(str.not_blank(""))
    end)
    it("not blank", function()
      assert_true(str.not_blank(" x"))
      assert_true(str.not_blank(" asdf "))
      assert_false(str.blank("y "))
      assert_false(str.blank(" asdf "))
    end)
  end)
  describe("[find]", function()
    it("found", function()
      assert_eq(str.find("abcdefg", "a"), 1)
      assert_eq(str.find("abcdefg", "a", 1), 1)
      assert_eq(str.find("abcdefg", "g"), 7)
      assert_eq(str.find("abcdefg", "g", 1), 7)
      assert_eq(str.find("abcdefg", "g", 7), 7)
      assert_eq(str.find("fzfx -- -w -g *.lua", "--"), 6)
      assert_eq(str.find("fzfx -- -w -g *.lua", "--", 1), 6)
      assert_eq(str.find("fzfx -- -w -g *.lua", "--", 2), 6)
      assert_eq(str.find("fzfx -- -w -g *.lua", "--", 3), 6)
      assert_eq(str.find("fzfx -- -w -g *.lua", "--", 6), 6)
      assert_eq(str.find("fzfx -w -- -g *.lua", "--"), 9)
      assert_eq(str.find("fzfx -w -- -g *.lua", "--", 1), 9)
      assert_eq(str.find("fzfx -w -- -g *.lua", "--", 2), 9)
      assert_eq(str.find("fzfx -w ---g *.lua", "--", 8), 9)
      assert_eq(str.find("fzfx -w ---g *.lua", "--", 9), 9)
    end)
    it("not found", function()
      assert_eq(str.find("abcdefg", "a", 2), nil)
      assert_eq(str.find("abcdefg", "a", 7), nil)
      assert_eq(str.find("abcdefg", "g", 8), nil)
      assert_eq(str.find("abcdefg", "g", 9), nil)
      assert_eq(str.find("fzfx -- -w -g *.lua", "--", 7), nil)
      assert_eq(str.find("fzfx -- -w -g *.lua", "--", 8), nil)
      assert_eq(str.find("fzfx -w -- -g *.lua", "--", 10), nil)
      assert_eq(str.find("fzfx -w -- -g *.lua", "--", 11), nil)
      assert_eq(str.find("fzfx -w ---g *.lua", "--", 11), nil)
      assert_eq(str.find("fzfx -w ---g *.lua", "--", 12), nil)
      assert_eq(str.find("", "--"), nil)
      assert_eq(str.find("", "--", 1), nil)
      assert_eq(str.find("-", "--"), nil)
      assert_eq(str.find("--", "---", 1), nil)
    end)
  end)
  describe("[rfind]", function()
    it("found", function()
      assert_eq(str.rfind("abcdefg", "a"), 1)
      assert_eq(str.rfind("abcdefg", "a", 1), 1)
      assert_eq(str.rfind("abcdefg", "a", 7), 1)
      assert_eq(str.rfind("abcdefg", "a", 2), 1)
      assert_eq(str.rfind("abcdefg", "g"), 7)
      assert_eq(str.rfind("abcdefg", "g", 7), 7)
      assert_eq(str.rfind("fzfx -- -w -g *.lua", "--"), 6)
      assert_eq(str.rfind("fzfx -- -w -g *.lua", "--", 6), 6)
      assert_eq(str.rfind("fzfx -- -w -g *.lua", "--", 7), 6)
      assert_eq(str.rfind("fzfx -- -w -g *.lua", "--", 8), 6)
      assert_eq(str.rfind("fzfx -w -- -g *.lua", "--"), 9)
      assert_eq(str.rfind("fzfx -w -- -g *.lua", "--", 10), 9)
      assert_eq(str.rfind("fzfx -w -- -g *.lua", "--", 9), 9)
      assert_eq(str.rfind("fzfx -w -- -g *.lua", "--", 10), 9)
      assert_eq(str.rfind("fzfx -w -- -g *.lua", "--", 11), 9)
      assert_eq(str.rfind("fzfx -w ---g *.lua", "--", 9), 9)
      assert_eq(str.rfind("fzfx -w ---g *.lua", "--", 10), 10)
      assert_eq(str.rfind("fzfx -w ---g *.lua", "--", 11), 10)
    end)
    it("not found", function()
      assert_eq(str.rfind("abcdefg", "a", 0), nil)
      assert_eq(str.rfind("abcdefg", "a", -1), nil)
      assert_eq(str.rfind("abcdefg", "g", 6), nil)
      assert_eq(str.rfind("abcdefg", "g", 5), nil)
      assert_eq(str.rfind("fzfx -- -w -g *.lua", "--", 5), nil)
      assert_eq(str.rfind("fzfx -- -w -g *.lua", "--", 4), nil)
      assert_eq(str.rfind("fzfx -- -w -g *.lua", "--", 1), nil)
      assert_eq(str.rfind("fzfx -w -- -g *.lua", "--", 8), nil)
      assert_eq(str.rfind("fzfx -w -- -g *.lua", "--", 7), nil)
      assert_eq(str.rfind("fzfx -w ---g *.lua", "--", 8), nil)
      assert_eq(str.rfind("fzfx -w ---g *.lua", "--", 7), nil)
      assert_eq(str.rfind("", "--"), nil)
      assert_eq(str.rfind("", "--", 1), nil)
      assert_eq(str.rfind("-", "--"), nil)
      assert_eq(str.rfind("--", "---", 1), nil)
    end)
  end)
  describe("[ltrim/rtrim/trim]", function()
    it("ltrim", function()
      assert_eq(str.ltrim("asdf"), "asdf")
      assert_eq(str.ltrim("a sdf"), "a sdf")
      assert_eq(str.ltrim(" asdf"), "asdf")
      assert_eq(str.ltrim(" \nasdf"), "asdf")
      assert_eq(str.ltrim("\tas df"), "as df")
      assert_eq(str.ltrim(" asdf  "), "asdf  ")
      assert_eq(str.ltrim(" \nasdf\n"), "asdf\n")
      assert_eq(str.ltrim("\tas\tdf\t"), "as\tdf\t")
      assert_eq(str.ltrim("\tasdf\t", "\ta"), "sdf\t")
      assert_eq(str.ltrim("a\nsdf", ".+"), "")
      assert_eq(str.ltrim("\tasd f\t", "%s+"), "asd f\t")
    end)
    it("rtrim", function()
      assert_eq(str.rtrim("asdf"), "asdf")
      assert_eq(str.rtrim(" asdf "), " asdf")
      assert_eq(str.rtrim(" as df "), " as df")
      assert_eq(str.rtrim(" \nasdf"), " \nasdf")
      assert_eq(str.rtrim(" \nasdf\n"), " \nasdf")
      assert_eq(str.rtrim("\tasdf\t"), "\tasdf")
      assert_eq(str.rtrim("\tas\tdf\t", "df\t"), "\tas\t")
      assert_eq(str.rtrim("\tasdf\t", ".+"), "")
      assert_eq(str.rtrim("\tasdf\t", "%s+"), "\tasdf")
    end)
    it("trim", function()
      assert_eq(str.trim("asdf"), "asdf")
      assert_eq(str.trim(" asdf "), "asdf")
      assert_eq(str.trim(" \nasdf"), "asdf")
      assert_eq(str.trim(" \nasdf\n"), "asdf")
      assert_eq(str.trim("\tasdf\t"), "asdf")
      assert_eq(str.trim("\tasdf\t", "\t"), "asdf")
    end)
  end)
  describe("[split]", function()
    it("splits rg options-1", function()
      local actual = str.split("-w -g *.md", " ", { trimempty = true })
      local expect = { "-w", "-g", "*.md" }
      assert_eq(#actual, #expect)
      for i, v in ipairs(actual) do
        assert_eq(v, expect[i])
      end
    end)
    it("splits rg options-2", function()
      local actual = str.split("  -w -g *.md  ", " ", { trimempty = true })
      local expect = { "-w", "-g", "*.md" }
      assert_eq(#actual, #expect)
      for i, v in ipairs(actual) do
        assert_eq(v, expect[i])
      end
    end)
    it("splits rg options-3", function()
      local actual = str.split("  -w -g *.md  ", " ", { plain = false, trimempty = false })
      local expect = { "", "", "-w", "-g", "*.md", "", "" }
      print(string.format("splits rg3, actual:%s\n", vim.inspect(actual)))
      print(string.format("splits rg3, expect:%s\n", vim.inspect(expect)))
      assert_eq(#actual, #expect)
      for i, v in ipairs(actual) do
        assert_eq(v, expect[i])
      end
    end)
    it("splits whitespaces", function()
      local actual =
        str.split(" '           1               0      ", " ", { plain = true, trimempty = true })
      local expect = {
        "'",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "1",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "0",
      }
      print(string.format("splits whitespaces-4, actual:%s\n", vim.inspect(actual)))
      print(string.format("splits whitespaces-4, expect:%s\n", vim.inspect(expect)))
      assert_eq(#actual, #expect)
      for i, v in ipairs(actual) do
        assert_eq(v, expect[i])
      end
    end)
  end)
  describe("[startswith]", function()
    it("test", function()
      assert_true(str.startswith("hello world", "hello"))
      assert_false(str.startswith("hello world", "ello"))
    end)
    it("test case ignored", function()
      assert_true(str.startswith("HEllo world", "hello", { ignorecase = true }))
      assert_false(str.startswith("HEllo world", "ello", { ignorecase = true }))
    end)
  end)
  describe("[endswith]", function()
    it("test", function()
      assert_true(str.endswith("hello world", "world"))
      assert_false(str.endswith("hello world", "hello"))
    end)
    it("test case ignored", function()
      assert_true(str.endswith("hello WORLD", "world", { ignorecase = true }))
      assert_false(str.endswith("hello WORLD", "hello", { ignorecase = true }))
    end)
  end)
  describe("[replace]", function()
    it("test", function()
      local actual1 = str.replace("hello world", "world", "goodbye")
      assert_eq(actual1, "hello goodbye")
      local actual2 = str.replace("hello world", "hello", "goodbye")
      assert_eq(actual2, "goodbye world")
      local actual3 = str.replace("hellonihao", "oni", "goodbye")
      assert_eq(actual3, "hellgoodbyehao")
      local actual4, ok4 = str.replace("hellohellohello", "hello", "goodbye")
      assert_eq(actual4, "goodbyegoodbyegoodbye")
    end)
  end)
  describe("[isxxx]", function()
    local function _contains_char(s, c)
      assert(string.len(s) > 0)
      assert(string.len(c) == 1)
      for i = 1, #s do
        if string.byte(s, i) == string.byte(c, 1) then
          return true
        end
      end
      return false
    end

    local function _contains_code(s, c)
      for _, i in ipairs(s) do
        if i == c then
          return true
        end
      end
      return false
    end

    it("isspace", function()
      local whitespaces = "\r\n \t"
      local char_codes = { 11, 12 }
      for i = 1, 255 do
        if _contains_char(whitespaces, string.char(i)) or _contains_code(char_codes, i) then
          assert_true(str.isspace(string.char(i)))
        else
          -- print(
          --   string.format(
          --     "isspace: %d: %s\n",
          --     i,
          --     vim.inspect(strs.isspace(string.char(i)))
          --   )
          -- )
          assert_false(str.isspace(string.char(i)))
        end
      end
    end)
    it("isalpha", function()
      local a = "a"
      local z = "z"
      local A = "A"
      local Z = "Z"
      for i = 1, 255 do
        if
          (i >= string.byte(a) and i <= string.byte(z))
          or (i >= string.byte(A) and i <= string.byte(Z))
        then
          assert_true(str.isalpha(string.char(i)))
        else
          assert_false(str.isalpha(string.char(i)))
        end
      end
    end)
    it("isdigit", function()
      local _0 = "0"
      local _9 = "9"
      for i = 1, 255 do
        if i >= string.byte(_0) and i <= string.byte(_9) then
          assert_true(str.isdigit(string.char(i)))
        else
          assert_false(str.isdigit(string.char(i)))
        end
      end
    end)
    it("isalnum", function()
      local a = "a"
      local z = "z"
      local A = "A"
      local Z = "Z"
      local _0 = "0"
      local _9 = "9"
      for i = 1, 255 do
        if
          (i >= string.byte(a) and i <= string.byte(z))
          or (i >= string.byte(A) and i <= string.byte(Z))
          or (i >= string.byte(_0) and i <= string.byte(_9))
        then
          assert_true(str.isalnum(string.char(i)))
        else
          assert_false(str.isalnum(string.char(i)))
        end
      end
    end)
    it("ishex", function()
      local a = "a"
      local f = "f"
      local A = "A"
      local F = "F"
      local _0 = "0"
      local _9 = "9"
      for i = 1, 255 do
        if
          (i >= string.byte(a) and i <= string.byte(f))
          or (i >= string.byte(A) and i <= string.byte(F))
          or (i >= string.byte(_0) and i <= string.byte(_9))
        then
          assert_true(str.isxdigit(string.char(i)))
        else
          -- print(
          --   string.format(
          --     "ishex, %d:%s\n",
          --     i,
          --     vim.inspect(strs.ishex(string.char(i)))
          --   )
          -- )
          assert_false(str.isxdigit(string.char(i)))
        end
      end
    end)
    it("islower", function()
      local a = "a"
      local z = "z"
      for i = 1, 255 do
        if i >= string.byte(a) and i <= string.byte(z) then
          assert_true(str.islower(string.char(i)))
        else
          assert_false(str.islower(string.char(i)))
        end
      end
    end)
    it("isupper", function()
      local A = "A"
      local Z = "Z"
      for i = 1, 255 do
        if i >= string.byte(A) and i <= string.byte(Z) then
          assert_true(str.isupper(string.char(i)))
        else
          assert_false(str.isupper(string.char(i)))
        end
      end
    end)
  end)
  describe("[setchar]", function()
    it("test", function()
      assert_eq(str.setchar("abcdefg", 1, "b"), "bbcdefg")
      assert_eq(str.setchar("abcdefg", 2, "c"), "accdefg")
      assert_eq(str.setchar("abcdefg", 6, "a"), "abcdeag")
      assert_eq(str.setchar("abcdefg", 7, "-"), "abcdef-")
      assert_eq(str.setchar("abcdefg", -1, "a"), "abcdefa")
      assert_eq(str.setchar("abcdefg", -2, "a"), "abcdeag")
      assert_eq(str.setchar("abcdefg", -7, "-"), "-bcdefg")
    end)
  end)
  describe("[tochars]", function()
    it("test", function()
      assert_true(vim.deep_equal(str.tochars("abcdefg"), { "a", "b", "c", "d", "e", "f", "g" }))
      assert_true(vim.deep_equal(str.tochars(""), {}))
    end)
  end)
end)
