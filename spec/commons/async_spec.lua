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
            if err then
              print(
                string.format(
                  "async system-1 err:%s, data:%s\n",
                  vim.inspect(err),
                  vim.inspect(data)
                )
              )
              return
            end
            if type(data) == "string" then
              stdout_data = stdout_data .. data
            else
              print(string.format("async system-1 data (not string):%s\n", vim.inspect(data)))
            end
          end,
        })
        print(string.format("async system-1 completed:%s\n", vim.inspect(completed1)))
        print(string.format("async system-1 stdout:%s\n", vim.inspect(stdout_data)))
      end)()

      async.void(function()
        local stdout_data = ""
        local completed2 = system({ "echo", "bar" }, {
          text = true,
          stdout = function(err, data)
            if err then
              print(
                string.format(
                  "async system-1 err:%s, data:%s\n",
                  vim.inspect(err),
                  vim.inspect(data)
                )
              )
              return
            end
            if type(data) == "string" then
              stdout_data = stdout_data .. data
            else
              print(string.format("async system-1 data (not string):%s\n", vim.inspect(data)))
            end
          end,
        })
        print(string.format("async system-2 completed:%s\n", vim.inspect(completed2)))
        print(string.format("async system-2 stdout:%s\n", vim.inspect(stdout_data)))
      end)()
    end)
  end)
end)
