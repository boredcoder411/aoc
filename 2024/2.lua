-- Function to check if a report is safe
function isReportSafe(report)
    local flagIncrease, flagDecrease = false, false

    for i = 2, #report do
        local diff = report[i] - report[i - 1]

        if diff > 0 then
            flagIncrease = true
        elseif diff < 0 then
            flagDecrease = true
        else
            return false
        end

        if flagIncrease and flagDecrease then
            return false
        end

        if math.abs(diff) > 3 then
            return false
        end
    end

    return true
end

-- Function to process all reports
function getTotalSafeReportCount(reports)
    local count = 0

    for _, report in ipairs(reports) do
        local nums = {}
        for num in string.gmatch(report, "%d+") do
            table.insert(nums, tonumber(num))
        end

        if isReportSafe(nums) then
            count = count + 1
        end
    end

    print("answer for part 1:", count)
end

-- Read the input file 2.in
local reports = {}
for line in io.lines("2.in") do
    table.insert(reports, line)
end

getTotalSafeReportCount(reports)
