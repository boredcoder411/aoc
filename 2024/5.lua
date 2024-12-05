function parse_input(input)
    local rules = {}
    local updates = {}

    for line in input:gmatch("[^\r\n]+") do
        if line:find("|") then
            local x, y = line:match("(%d+)|(%d+)")
            rules[#rules + 1] = {tonumber(x), tonumber(y)}
        elseif line:find(",") then
            local update = {}
            for num in line:gmatch("%d+") do
                update[#update + 1] = tonumber(num)
            end
            updates[#updates + 1] = update
        end
    end

    return rules, updates
end

function is_valid_update(rules, update)
    local positions = {}
    for i, page in ipairs(update) do
        positions[page] = i
    end

    for _, rule in ipairs(rules) do
        local x, y = rule[1], rule[2]
        if positions[x] and positions[y] and positions[x] > positions[y] then
            return false
        end
    end

    return true
end

function find_middle(update)
    local mid = math.ceil(#update / 2)
    return update[mid]
end

function solve(input)
    local rules, updates = parse_input(input)
    local total = 0

    for _, update in ipairs(updates) do
        if is_valid_update(rules, update) then
            total = total + find_middle(update)
        end
    end

    return total
end

local lines = io.open("5.in"):lines()
local input = ""
for line in lines do
    input = input .. line .. "\n"
end

print("Total middle page numbers sum:", solve(input))

