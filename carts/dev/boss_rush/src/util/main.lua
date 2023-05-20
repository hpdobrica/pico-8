
function calculateSteps(pieces)
    local steps = {}
    local step = 1 / pieces
    for i = 0, pieces do
        steps[#steps + 1] = i * step
    end
    return steps
end

function roundToStep(number, numOfSteps)
    local steps = calculateSteps(numOfSteps)
    local closestStep = steps[1]
    local closestDistance = abs(number - closestStep)

    for i = 2, #steps do
        local distance = abs(number - steps[i])
        if distance < closestDistance then
            closestStep = steps[i]
            closestDistance = distance
        end
    end

    return closestStep
end
