-- read 1.in lines into a table
local lines = {}
for line in io.lines("1.in") do
    table.insert(lines, line)
end

local L, R = {}, {}

for i, e in ipairs(lines) do
  local Li, Ri = e:match("(%d+)%s*(%d+)")
  table.insert(L, tonumber(Li))
  table.insert(R, tonumber(Ri))
end

-- sort the tables
table.sort(L)
table.sort(R)

-- for each element in L, find the number at the same index in R and calculate their distance
local sum = 0
for i, e in ipairs(L) do
  sum = sum + math.abs(e - R[i])
end

print(sum)
