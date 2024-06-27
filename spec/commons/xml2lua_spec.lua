local cwd = vim.fn.getcwd()

describe("commons.version", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local xml2lua = require("commons.xml2lua")

  describe("[xml2lua]", function()
    local PAYLOAD = [[
<people>
  <person type="natural">
    <name>Manoel</name>
    <city>Palmas-TO</city>
  </person>
  <person type="legal">
    <name>University of Brasília</name>
    <city>Brasília-DF</city>
  </person>
</people>
]]
    local DATA_TABLE = {
      person = {
        { name = "Manoel", city = "Palmas-TO", _attr = { type = "natural" } },
        { name = "Breno", city = "Palmas-TO", _attr = { type = "legal" } },
      },
    }
    it("parse", function()
      local handler = require("commons.xmlhandler.tree")
      local parser = xml2lua.parser(handler)
      parser:parse(PAYLOAD)
      print(string.format("parser, handler:%s\n", vim.inspect(handler)))
      assert_eq(type(handler.root.people.person), "table")
      for i, p in pairs(handler.root.people.person) do
        print(string.format("parser-%d:%s\n", i, vim.inspect(p)))
        assert_eq(type(p.name), "string")
        assert_eq(type(p.city), "string")
      end
    end)
    it("toXml", function()
      local actual1 = xml2lua.printable(DATA_TABLE)
      print("toXml printable:%s\n", vim.inspect(actual1))
      local actual2 = xml2lua.toXml(DATA_TABLE, "people")
      print("toXml:%s\n", vim.inspect(actual2))
      assert_eq(type(actual2), "string")
    end)
  end)
end)
