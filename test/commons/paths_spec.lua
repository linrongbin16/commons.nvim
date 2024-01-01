local cwd = vim.fn.getcwd()

describe("commons.paths", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local strings = require("commons.strings")
  local paths = require("commons.paths")

  describe("[normalize]", function()
    it("unix", function()
      local expect1 = "~/github/linrongbin16/fzfx.nvim/lua/tests"
      local actual1 = paths.normalize(expect1)
      local expect2 = "~/github/linrongbin16/fzfx.nvim/lua/tests/test_path.lua"
      local actual2 = paths.normalize(expect2)
      assert_eq(actual1, expect1)
      assert_eq(actual2, expect2)

      local expect3 = "test/lib/paths_spec.lua"
      local actual3 =
        paths.normalize(expect3, { expand = true, resolve = true })
      -- print(
      --   string.format(
      --     "paths normalize, expect3:%s, actual3:%s\n",
      --     vim.inspect(vim.fn.expand(expect3)),
      --     vim.inspect(actual3)
      --   )
      -- )
      assert_eq(vim.fn.expand(expect3), actual3)
      vim.cmd([[!mkdir -p t1/t2]])
      vim.cmd([[!touch t1/t2/t3.txt]])
      vim.cmd([[!ln -s t3.txt t1/t2/t3.txt]])
      local actual4 =
        paths.normalize("t3.txt", { expand = true, resolve = true })
      print(string.format("normalize-4:%s\n", actual4))
    end)
    it("windows", function()
      local actual1 = paths.normalize(
        [[C:\Users\linrongbin\github\linrongbin16\fzfx.nvim\lua\tests]]
      )
      local expect1 =
        [[C:/Users/linrongbin/github/linrongbin16/fzfx.nvim/lua/tests]]
      assert_eq(actual1, expect1)

      local actual2 = paths.normalize(
        [[C:\Users\linrongbin\github\linrongbin16\fzfx.nvim\lua\tests]],
        { double_backslash = true }
      )
      local expect2 =
        [[C:/Users/linrongbin/github/linrongbin16/fzfx.nvim/lua/tests]]
      assert_eq(actual2, expect2)

      local actual3 = paths.normalize(
        [[C:\\Users\\linrongbin\\github\\linrongbin16\\fzfx.nvim\\lua\\tests\test_path.lua]],
        { double_backslash = true }
      )
      local expect3 =
        [[C:/Users/linrongbin/github/linrongbin16/fzfx.nvim/lua/tests/test_path.lua]]
      assert_eq(actual3, expect3)

      local actual4 = paths.normalize(
        [[C:\\Users\\linrongbin\\github\\linrongbin16\\fzfx.nvim\\lua\\tests\\test_path.lua]],
        { double_backslash = true }
      )
      local expect4 =
        [[C:/Users/linrongbin/github/linrongbin16/fzfx.nvim/lua/tests/test_path.lua]]
      assert_eq(actual4, expect4)
    end)
  end)
  describe("[join]", function()
    it("test", function()
      local actual1 = paths.join("a", "b", "c")
      local expect1 = "a/b/c"
      assert_eq(actual1, expect1)
      local actual2 = paths.join("a")
      local expect2 = "a"
      assert_eq(actual2, expect2)
    end)
  end)
  describe("[shorten]", function()
    it("test", function()
      local expect1 = "~/.config/nvim/lazy/fzfx.nvim/test/path_spec.lua"
      local actual1 = paths.shorten(expect1)
      print(string.format("expect(%s) shorten: %s\n", expect1, actual1))
      assert_eq(type(actual1), "string")
      assert_true(string.len(actual1) < string.len(expect1))
    end)
  end)
  describe("[reduce]", function()
    it("test", function()
      local expect1 = "~/.config/nvim/lazy/fzfx.nvim/test/path_spec.lua"
      local actual1 = paths.reduce(expect1)
      print(string.format("expect(%s) reduce: %s\n", expect1, actual1))
      assert_eq(type(actual1), "string")
      assert_eq(expect1, actual1)
    end)
  end)
  describe("[reduce2home]", function()
    it("test", function()
      local expect1 = "~/.config/nvim/lazy/fzfx.nvim/test/path_spec.lua"
      local actual1 = paths.reduce2home(expect1)
      print(string.format("expect(%s) reduce2home: %s\n", expect1, actual1))
      assert_eq(type(actual1), "string")
      assert_eq(expect1, actual1)
    end)
  end)
  describe("[pipename]", function()
    it("test", function()
      local tmp = paths.pipename()
      assert_true(string.len(tmp) > 0)
    end)
  end)
  describe("[parent]", function()
    it("test", function()
      local input1 = "~/.config/nvim/lazy/fzfx.nvim/test/path_spec.lua"
      local actual1 = paths.parent(input1)
      local expect1 = "~/.config/nvim/lazy/fzfx.nvim/test"
      assert_eq(actual1, expect1)

      local input2 = "~/.config/nvim/lazy/fzfx.nvim/test"
      local actual2 = paths.parent(input2)
      local expect2 = "~/.config/nvim/lazy/fzfx.nvim"
      assert_eq(actual2, expect2)

      local input3 = "~/.config/nvim/lazy/fzfx.nvim"
      local actual3 = paths.parent(input3)
      local expect3 = "~/.config/nvim/lazy"
      assert_eq(actual3, expect3)

      local actual4 = paths.parent()
      assert_true(strings.startswith(cwd, actual4))

      local actual5 = paths.parent("/")
      assert_eq(actual5, nil)

      local actual6 = paths.parent("~/.config/nvim/lazy/")
      assert_eq(actual6, "~/.config/nvim")
    end)
  end)
end)
