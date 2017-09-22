local bloom = require("bloombool")
local socket = require("socket")

local filter = bloom.new(10000, 0.0001)

local dataset = {}
for line in io.lines('./list') do
  table.insert(dataset, line)
end

-- add many liste to the file
local i = 0
local timer1 = socket.gettime()*1000
for _, line in ipairs(dataset) do
  filter.add(line)
  i = i + 1
end
local timer2 = socket.gettime()*1000
print('Added ' .. i .. ' items to the filter in ' .. timer2 - timer1 .. ' msec')
print(i / ((timer2 - timer1)) .. ' inserts per msec')
print()

-- check that they are in the list
i = 0
timer1 = socket.gettime()*1000
for _, line in ipairs(dataset) do
  filter.check(line)
  i = i + 1
end
timer2 = socket.gettime()*1000
print('Checked ' .. i .. ' items in the filter in ' .. timer2 - timer1 .. ' msec')
print(i / ((timer2 - timer1)) .. ' inserts per msec')
