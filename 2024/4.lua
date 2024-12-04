function range (from, to)
  return function (_, last)
    if last >= to then return nil
    else return last + 1
    end
  end, nil, from - 1
end

lines = {}
for line in io.lines("4.in") do
  table.insert(lines, line)
end

n = #lines
m = #lines[1]

dd = {}
for dx in range(-1, 2) do
  for dy in range(-1, 2) do
    if dx ~= 0 or dy ~= 0 then
      table.insert(dd, {dx, dy})
    end
  end
end

function has_xmas(i, j, d)
  local dx, dy = d[1], d[2]
  for k = 1, #("XMAS") do
    local x = string.sub("XMAS", k, k)
    local ii = i + (k - 1) * dx
    local jj = j + (k - 1) * dy
    if not (ii >= 1 and ii <= n and jj >= 1 and jj <= m) then
      return false
    end
    if lines[ii]:sub(jj, jj) ~= x then
      return false
    end
  end
  return true
end

local ans = 0
for i = 1, n do
  for j = 1, m do
    for _, d in ipairs(dd) do
      if has_xmas(i, j, d) then
        ans = ans + 1
      end
    end
  end
end

print(ans)
