lines = {}
for line in io.lines("3.in") do
  table.insert(lines, line)
end

memory = table.concat(lines, "")
memory = memory:gsub("\n", "")

local regex = "mul%((%d+),(%d+)%)"

local total = 0

for a, b in memory:gmatch(regex) do
    total = total + tonumber(a) * tonumber(b)
end

print(total)
