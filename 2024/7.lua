local function generate_combinations(length)
    local function recurse(current, remaining)
        if remaining == 0 then
            coroutine.yield(current)
            return
        end
        for _, op in ipairs({"*", "+"}) do
            local new_combination = current .. op
            recurse(new_combination, remaining - 1)
        end
    end

    return coroutine.wrap(function()
        recurse("", length)
    end)
end

local function test_combination(nums, combo)
    local ans = nums[1]
    for i = 2, #nums do
        local op = combo:sub(i-1, i-1)
        if op == "+" then
            ans = ans + nums[i]
        else
            ans = ans * nums[i]
        end
    end
    return ans
end

local file = io.open("./7.in", "r")
local content = file:read("*all"):gsub("\n$", "")
file:close()

local lines = {}
for line in content:gmatch("[^\n]+") do
    table.insert(lines, line)
end

local total_ans = 0

for i, line in ipairs(lines) do
    local parts = {}
    for part in line:gmatch("%S+") do
        table.insert(parts, part)
    end

    local value = tonumber(parts[1]:sub(1, -2))
    local nums = {}
    for j = 2, #parts do
        table.insert(nums, tonumber(parts[j]))
    end

    local found = false
    for combo in generate_combinations(#nums - 1) do
        if test_combination(nums, combo) == value then
            print(string.format("[%02d/%d] WORKS %s %d", i, #lines, combo, value))
            total_ans = total_ans + value
            found = true
            break
        end
    end

    if not found then
        print(string.format("[%02d/%d] NO SOLUTION", i, #lines))
    end
end

print(total_ans)
