-- Open the file and read the lines into a table
local file = io.open("./6.in", "r")
local grid = {}
for line in file:lines() do
    table.insert(grid, line)
end
file:close()

local n = #grid
local m = #grid[1]

-- Find the starting position (^) in the grid
local found = false
local i, j
for row = 1, n do
    for col = 1, m do
        if grid[row]:sub(col, col) == "^" then
            i, j = row, col
            found = true
            break
        end
    end
    if found then
        break
    end
end

-- Direction vectors for up, right, down, and left
local dir = 1
local dd = {
    {-1, 0},  -- up
    {0, 1},   -- right
    {1, 0},   -- down
    {0, -1},  -- left
}

-- Set to keep track of visited positions
local seen = {}
local function add_seen(x, y)
    seen[x] = seen[x] or {}
    seen[x][y] = true
end

-- Start the movement
while true do
    add_seen(i, j)

    local next_i = i + dd[dir][1]
    local next_j = j + dd[dir][2]

    if not (next_i >= 1 and next_i <= n and next_j >= 1 and next_j <= m) then
        break
    end

    if grid[next_i]:sub(next_j, next_j) == "#" then
        dir = (dir % 4) + 1  -- turn 90 degrees clockwise
    else
        i, j = next_i, next_j
    end
end

-- Count the number of unique positions visited
local count = 0
for x, row in pairs(seen) do
    for y, _ in pairs(row) do
        count = count + 1
    end
end

print(count)

