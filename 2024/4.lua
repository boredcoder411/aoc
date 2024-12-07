-- Open the file and read the lines into a table
local file = io.open("./4.in", "r")
local lines = {}
for line in file:lines() do
    table.insert(lines, line)
end
file:close()

local n = #lines
local m = #lines[1]

-- Generate all directions
local dd = {}
for dx = -1, 1 do
    for dy = -1, 1 do
        if dx ~= 0 or dy ~= 0 then
            table.insert(dd, {dx, dy})
        end
    end
end

-- Function to check if "XMAS" exists in the given direction
local function has_xmas(i, j, d)
    local dx, dy = d[1], d[2]
    for k = 1, #("XMAS") do
        local ii = i + (k - 1) * dx
        local jj = j + (k - 1) * dy
        if ii < 1 or ii > n or jj < 1 or jj > m then
            return false
        end
        if lines[ii]:sub(jj, jj) ~= ("XMAS"):sub(k, k) then
            return false
        end
    end
    return true
end

-- Count occurrences of "XMAS" in all directions
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

