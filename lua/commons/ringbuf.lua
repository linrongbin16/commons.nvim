-- Drop-in replacement 'RingBuffer' data structure

local M = {}

--- @class commons.RingBuffer
--- @field pos integer
--- @field queue any[]
--- @field size integer
--- @field maxsize integer
local RingBuffer = {}

--- @param maxsize integer?
--- @return commons.RingBuffer
function RingBuffer:new(maxsize)
  assert(type(maxsize) == "number" and maxsize > 0)
  local o = {
    pos = 0,
    queue = {},
    size = 0,
    maxsize = maxsize,
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function RingBuffer:_inc_pos()
  if self.pos == self.maxsize then
    self.pos = 1
  else
    self.pos = self.pos + 1
  end
end

function RingBuffer:_dec_pos()
  if self.pos == 1 then
    self.pos = self.maxsize
  else
    self.pos = self.pos - 1
  end
end

--- @param item any
--- @return integer
function RingBuffer:push(item)
  assert(self.size >= 0 and self.size <= self.maxsize)

  if self.size < self.maxsize then
    table.insert(self.queue, item)
    self:_inc_pos()
    self.size = self.size + 1
  else
    self:_inc_pos()
    self.queue[self.pos] = item
  end
  return self.pos
end

--- @return any?
function RingBuffer:pop()
  if self.size <= 0 then
    return nil
  end

  local old = self.queue[self.pos]
  self.queue[self.pos] = nil
  self.size = self.size - 1
  self:_dec_pos()
  return old
end

--- @return any?
function RingBuffer:peek()
  if self.size <= 0 then
    return nil
  end
  return self.queue[self.pos]
end

--- @return integer
function RingBuffer:clear()
  local old = self.size
  self.pos = 0
  self.queue = {}
  self.size = 0
  return old
end

-- get the item on pos, or the last pushed item
--
--- @param pos integer?
--- @return any?
function RingBuffer:get(pos)
  pos = pos or self.pos
  if #self.queue == 0 or pos == 0 then
    return nil
  else
    return self.queue[pos]
  end
end

-- iterate from oldest to newest, usage:
--
-- ```lua
--  local p = ring_buffer:begin()
--  while p ~= nil then
--    local item = ring_buffer:get(p)
--    p = ring_buffer:next(p)
--  end
-- ```
--
--- @return integer?
function RingBuffer:begin()
  if #self.queue == 0 or self.pos == 0 then
    return nil
  end
  if self.pos == #self.queue then
    return 1
  else
    return self.pos + 1
  end
end

-- iterate from oldest to newest
--- @param pos integer
--- @return integer?
function RingBuffer:next(pos)
  if #self.queue == 0 or pos == 0 then
    return nil
  end
  if pos == self.pos then
    return nil
  end
  if pos == #self.queue then
    return 1
  else
    return pos + 1
  end
end

-- iterate from newest to oldest, usage:
--
-- ```lua
--  local p = ring_buffer:rbegin()
--  while p ~= nil then
--    local item = ring_buffer:get(p)
--    p = ring_buffer:rnext()
--  end
-- ```
--
--- @return integer?
function RingBuffer:rbegin()
  if #self.queue == 0 or self.pos == 0 then
    return nil
  end
  return self.pos
end

-- iterate from newest to oldest
--- @param pos integer
--- @return integer?
function RingBuffer:rnext(pos)
  if #self.queue == 0 or pos == 0 then
    return nil
  end
  if self.pos == 1 and pos == #self.queue then
    return nil
  elseif pos == self.pos then
    return nil
  end
  if pos == 1 then
    return #self.queue
  else
    return pos - 1
  end
end

M.RingBuffer = RingBuffer

return M
