local cwd = vim.fn.getcwd()

describe("commons.path", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local IS_WINDOWS = vim.fn.has("win32") > 0 or vim.fn.has("win64") > 0

  local str = require("commons.str")
  local path = require("commons.path")
  local uv = require("commons.uv")

  local function create_symlink(p1, p2)
    if IS_WINDOWS then
      vim.cmd(string.format([[!rm %s]], p1))
      vim.cmd(string.format([[!rm %s]], p2))
      vim.cmd(string.format([[!touch %s]], p1))
      vim.cmd(string.format([[!mklink %s %s]], p2, p1))
    else
      vim.cmd(string.format([[!rm %s]], p1))
      vim.cmd(string.format([[!rm %s]], p2))
      vim.cmd(string.format([[!touch %s]], p1))
      vim.cmd(string.format([[!ln -s %s  %s]], p1, p2))
    end
  end

  local function remove_file(p)
    if vim.fn.has("win32") > 0 or vim.fn.has("win64") > 0 then
      vim.cmd(string.format([[!rm %s]], p))
    else
      vim.cmd(string.format([[!rm %s]], p))
    end
  end

  describe("[exists/isfile/isdir/issymlink]", function()
    it("exists", function()
      local expect1 = "spec/commons/path_spec.lua"
      assert_true(path.exists(expect1))
      local expect2 = "asdf-test1"
      assert_false(path.exists(expect2))
      local expect3 = "spec/commons"
      assert_true(path.exists(expect3))
    end)
    it("isfile", function()
      local expect1 = "spec/commons/path_spec.lua"
      assert_true(path.isfile(expect1))
      local expect2 = "asdf-test2"
      assert_false(path.isfile(expect2))
      local expect3 = "spec/commons"
      assert_false(path.isfile(expect3))
    end)
    it("isdir", function()
      local expect1 = "spec/commons/path_spec.lua"
      assert_false(path.isdir(expect1))
      local expect2 = "asdf-test3"
      assert_false(path.isdir(expect2))
      local expect3 = "spec/commons"
      assert_true(path.isdir(expect3))
    end)
    it("islink", function()
      local expect1 = "spec/commons/path_spec.lua"
      assert_false(path.islink(expect1))
      local expect2 = "asdf-test4"
      assert_false(path.islink(expect2))
      local expect3 = "spec/commons"
      assert_false(path.islink(expect3))

      local expect41 = "test7.txt"
      local expect42 = "test8.txt"
      create_symlink(expect41, expect42)
      assert_false(path.islink(expect41))
      assert_true(path.islink(expect42))
      remove_file(expect41)
      remove_file(expect42)
    end)
  end)
  describe("[expand]", function()
    local expect1 = "~/github/linrongbin16/fzfx.nvim/lua/tests"
    local actual1 = path.expand(expect1)
    assert_true(str.endswith(actual1, string.sub(expect1, 3)))
  end)
  describe("[resolve]", function()
    local expect11 = "test311.txt"
    local expect12 = "test312.txt"
    create_symlink(expect11, expect12)
    local actual1 = path.resolve(expect12)
    print(string.format("resolve-1:%s\n", vim.inspect(actual1)))
    assert_true(str.endswith(actual1, expect11))
    remove_file(expect11)
    remove_file(expect12)
  end)
  describe("[normalize]", function()
    it("user.home", function()
      local expect1 = "~/github/linrongbin16/fzfx.nvim/lua/tests"
      local actual1 = path.normalize(expect1)
      assert_eq(actual1, expect1)

      local expect2 = "~/github/linrongbin16/fzfx.nvim/lua/tests/test_path.lua"
      local actual2 = path.normalize(expect2)
      assert_eq(actual2, expect2)

      local expect3 = "~/github/linrongbin16/fzfx.nvim/lua/tests/test_path.lua"
      local actual3 = path.normalize(expect3, { expand = true })
      print(string.format("normalize-user.home-3:%s\n", vim.inspect(actual3)))
      assert_true(str.endswith(actual3, string.sub(expect3, 2)))
      assert_true(str.startswith(actual3, path.normalize(uv.os_homedir())))

      -- if not IS_WINDOWS then
      local expect41 = "~/test141.txt"
      local expect42 = "~/test142.txt"
      -- create_symlink(expect41, expect42)
      local actual4 = path.normalize(expect42, { expand = true, resolve = true })
      print(string.format("normalize-user.home-4:%s\n", vim.inspect(actual4)))
      -- assert_true(strings.endswith(actual4, string.sub(expect41, 2)))
      assert_true(str.startswith(actual4, path.normalize(uv.os_homedir())))
      -- remove_file(expect41)
      -- remove_file(expect42)
      -- end

      local expect51 = "~/test151.txt"
      local expect52 = "~/test152.txt"
      create_symlink(expect51, expect52)
      local actual5 = path.normalize(expect52, { resolve = true })
      print(string.format("normalize-user.home-5:%s\n", vim.inspect(actual5)))
      assert_eq(expect52, actual5)
    end)
    it("relative", function()
      local expect1 = "github/linrongbin16/fzfx.nvim/lua/tests"
      local actual1 = path.normalize(expect1)
      print(string.format("normalize-relative-1:%s\n", vim.inspect(actual1)))
      assert_eq(actual1, expect1)

      local expect2 = "./github/linrongbin16/fzfx.nvim/lua/tests/test_path.lua"
      local actual2 = path.normalize(expect2)
      print(string.format("normalize-relative-2:%s\n", vim.inspect(actual2)))
      assert_eq(actual2, expect2)

      local expect3 = "./spec/commons/path_spec.lua"
      local actual3 = path.normalize(expect3, { expand = true })
      print(string.format("normalize-relative-3:%s\n", vim.inspect(actual3)))
      assert_eq(actual3, expect3)

      local expect4 = "./spec/commons/path_spec.lua"
      local actual4 = path.normalize(expect4, { expand = true, resolve = true })
      print(string.format("normalize-relative-4:%s\n", vim.inspect(actual4)))
      assert_eq(actual4, expect4)

      local expect51 = "test251.txt"
      local expect52 = "test252.txt"
      create_symlink(expect51, expect52)
      local actual5 = path.normalize(expect52, { resolve = true })
      print(string.format("normalize-relative-5:%s\n", vim.inspect(actual5)))
      assert_true(str.endswith(actual5, expect51))
      remove_file(expect51)
      remove_file(expect52)

      local expect61 = IS_WINDOWS and ".\\test253.txt" or "./test253.txt"
      local expect62 = IS_WINDOWS and ".\\test254.txt" or "./test254.txt"
      create_symlink(expect61, expect62)
      local actual6 = path.normalize(expect62, { resolve = true })
      print(string.format("normalize-relative-6:%s\n", vim.inspect(actual6)))
      assert_true(str.endswith(actual6, string.sub(expect61, 3)))
      remove_file(expect61)
      remove_file(expect62)

      local expect7 = "github/linrongbin16/fzfx.nvim/lua/tests"
      local actual7 = path.normalize(expect1, { expand = true, resolve = true })
      print(string.format("normalize-relative-7:%s\n", vim.inspect(actual7)))
      assert_eq(actual7, expect7)
    end)
    it("windows", function()
      local actual1 =
        path.normalize([[C:\Users\linrongbin\github\linrongbin16\fzfx.nvim\lua\tests]])
      local expect1 = [[C:/Users/linrongbin/github/linrongbin16/fzfx.nvim/lua/tests]]
      assert_eq(actual1, expect1)

      local actual2 = path.normalize(
        [[C:\Users\linrongbin\github\linrongbin16\fzfx.nvim\lua\tests]],
        { double_backslash = true }
      )
      local expect2 = [[C:/Users/linrongbin/github/linrongbin16/fzfx.nvim/lua/tests]]
      assert_eq(actual2, expect2)

      local actual3 = path.normalize(
        [[C:\\Users\\linrongbin\\github\\linrongbin16\\fzfx.nvim\\lua\\tests\test_path.lua]],
        { double_backslash = true }
      )
      local expect3 = [[C:/Users/linrongbin/github/linrongbin16/fzfx.nvim/lua/tests/test_path.lua]]
      assert_eq(actual3, expect3)

      local actual4 = path.normalize(
        [[C:\\Users\\linrongbin\\github\\linrongbin16\\fzfx.nvim\\lua\\tests\\test_path.lua]],
        { double_backslash = true }
      )
      local expect4 = [[C:/Users/linrongbin/github/linrongbin16/fzfx.nvim/lua/tests/test_path.lua]]
      assert_eq(actual4, expect4)
    end)
  end)
  describe("[join]", function()
    it("test", function()
      local actual1 = path.join("a", "b", "c")
      local expect1 = IS_WINDOWS and "a\\b\\c" or "a/b/c"
      assert_eq(actual1, expect1)
      local actual2 = path.join("a")
      local expect2 = "a"
      assert_eq(actual2, expect2)
    end)
  end)
  describe("[shorten]", function()
    it("test", function()
      local expect1 = "~/.config/nvim/lazy/fzfx.nvim/test/path_spec.lua"
      local actual1 = path.shorten(expect1)
      print(string.format("expect(%s) shorten: %s\n", expect1, actual1))
      assert_eq(type(actual1), "string")
      assert_true(string.len(actual1) < string.len(expect1))
    end)
  end)
  describe("[reduce]", function()
    it("test", function()
      local expect1 = "~/.config/nvim/lazy/fzfx.nvim/test/path_spec.lua"
      local actual1 = path.reduce(expect1)
      print(string.format("expect(%s) reduce: %s\n", expect1, actual1))
      assert_eq(type(actual1), "string")
      assert_eq(expect1, actual1)
    end)
  end)
  describe("[reduce2home]", function()
    it("test", function()
      local expect1 = "~/.config/nvim/lazy/fzfx.nvim/test/path_spec.lua"
      local actual1 = path.reduce2home(expect1)
      print(string.format("expect(%s) reduce2home: %s\n", expect1, actual1))
      assert_eq(type(actual1), "string")
      assert_eq(expect1, actual1)
    end)
  end)
  describe("[pipename]", function()
    it("test", function()
      local tmp = path.pipename()
      assert_true(string.len(tmp) > 0)
    end)
  end)
  describe("[parent]", function()
    it("test", function()
      local input1 = "~/.config/nvim/lazy/fzfx.nvim/test/path_spec.lua"
      local actual1 = path.parent(input1)
      local expect1 = "~/.config/nvim/lazy/fzfx.nvim/test"
      assert_eq(actual1, expect1)

      local input2 = "~/.config/nvim/lazy/fzfx.nvim/test"
      local actual2 = path.parent(input2)
      local expect2 = "~/.config/nvim/lazy/fzfx.nvim"
      assert_eq(actual2, expect2)

      local input3 = "~/.config/nvim/lazy/fzfx.nvim"
      local actual3 = path.parent(input3)
      local expect3 = "~/.config/nvim/lazy"
      assert_eq(actual3, expect3)

      local actual4 = path.parent()
      assert_true(str.startswith(cwd, actual4))

      local actual5 = path.parent("/")
      assert_eq(actual5, nil)

      local actual6 = path.parent("~/.config/nvim/lazy/")
      assert_eq(actual6, "~/.config/nvim")
    end)
  end)
end)
