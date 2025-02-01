local cwd = vim.fn.getcwd()

describe("commons.async", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local str = require("commons.str")
  local tbl = require("commons.tbl")
  local async = require("commons.async")
  local uv = require("commons.uv")

  describe("[wrap/void]", function()
    it("wrap", function()
      local system = async.wrap(vim.system --[[@as function]], 3)

      async.void(function()
        local stdout_data = ""
        local completed1 = system({ "echo", "foo" }, {
          text = true,
          stdout = function(err, data)
            stdout_data = stdout_data .. data
          end,
        })
        print(string.format("async spawn-1 completed:%s", vim.inspect(completed1)))
        print(string.format("async spawn-1 stdout:%s", vim.inspect(stdout_data)))
      end)()

      async.void(function()
        local stdout_data = ""
        local completed2 = system({ "echo", "foo" }, {
          text = true,
          stdout = function(err, data)
            stdout_data = stdout_data .. data
          end,
        })
        print(string.format("async spawn-2 completed:%s", vim.inspect(completed2)))
        print(string.format("async spawn-2 stdout:%s", vim.inspect(stdout_data)))
      end)()
    end)
  end)
end)
