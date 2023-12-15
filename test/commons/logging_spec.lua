local cwd = vim.fn.getcwd()

describe("commons.logging", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local logging = require("commons.logging")
  local LogLevels = require("commons.logging").LogLevels
  local LogLevelNames = require("commons.logging").LogLevelNames

  logging.setup({
    name = "root",
    level = "DEBUG",
    console_log = true,
    file_log = true,
    file_log_name = "commons_test.log",
    file_log_dir = ".",
  })

  describe("[log]", function()
    it("debug", function()
      logging.debug("debug without parameters")
      logging.debug("debug with 1 parameters: %s", "a")
      logging.debug("debug with 2 parameters: %s, %d", "a", 1)
      logging.debug("debug with 3 parameters: %s, %d, %f", "a", 1, 3.12)
      assert_true(true)
    end)
    it("info", function()
      logging.info("info without parameters")
      logging.info("info with 1 parameters: %s", "a")
      logging.info("info with 2 parameters: %s, %d", "a", 1)
      logging.info("info with 3 parameters: %s, %d, %f", "a", 1, 3.12)
      assert_true(true)
    end)
    it("warn", function()
      logging.warn("warn without parameters")
      logging.warn("warn with 1 parameters: %s", "a")
      logging.warn("warn with 2 parameters: %s, %d", "a", 1)
      logging.warn("warn with 3 parameters: %s, %d, %f", "a", 1, 3.12)
      assert_true(true)
    end)
    it("err", function()
      logging.err("err without parameters")
      logging.err("err with 1 parameters: %s", "a")
      logging.err("err with 2 parameters: %s, %d", "a", 1)
      logging.err("err with 3 parameters: %s, %d, %f", "a", 1, 3.12)
      assert_true(true)
    end)
    it("ensure", function()
      logging.ensure(true, "ensure without parameters")
      logging.ensure(true, "ensure with 1 parameters: %s", "a")
      logging.ensure(true, "ensure with 2 parameters: %s, %d", "a", 1)
      logging.ensure(true, "ensure with 3 parameters: %s, %d, %f", "a", 1, 3.12)
      assert_true(true)
      local ok1, err1 =
        pcall(logging.ensure, false, "ensure without parameters")
      print(vim.inspect(err1) .. "\n")
      assert_false(ok1)
      local ok2, err2 =
        pcall(logging.ensure, false, "ensure with 1 parameters: %s", "a")
      print(vim.inspect(err2) .. "\n")
      assert_false(ok2)
      local ok3, err3 =
        pcall(logging.ensure, false, "ensure with 2 parameters: %s, %d", "a", 1)
      print(vim.inspect(err3) .. "\n")
      assert_false(ok3)
      local ok4, err4 = pcall(
        logging.ensure,
        false,
        "ensure with 3 parameters: %s, %d, %f",
        "a",
        1,
        3.12
      )
      print(vim.inspect(err4) .. "\n")
      assert_false(ok4)
    end)
    it("throw", function()
      local ok1, msg1 = pcall(logging.throw, "throw without params")
      assert_false(ok1)
      assert_eq(type(msg1), "string")
      local ok2, msg2 = pcall(logging.throw, "throw with 1 params: %s", "a")
      assert_false(ok2)
      assert_eq(type(msg2), "string")
      local ok3, msg3 =
        pcall(logging.throw, "throw with 2 params: %s, %d", "a", 2)
      assert_false(ok3)
      assert_eq(type(msg3), "string")
    end)
  end)
  describe("[LogLevels]", function()
    it("check levels", function()
      for k, v in pairs(LogLevels) do
        assert_eq(type(k), "string")
        assert_eq(type(v), "number")
      end
    end)
    it("check level names", function()
      for v, k in pairs(LogLevelNames) do
        assert_eq(type(k), "string")
        assert_eq(type(v), "number")
      end
    end)
  end)
end)
