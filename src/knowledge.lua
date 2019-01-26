-- HELPERS

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- MODULE

local m = {}

local connections = {}
local greetings = {}

local safeDialog = {
    [M.maybe_youll_make_a_friend] = {
        M.groan,
        M.fine,
        M.your_right,
    },
    [M.q_it_might_be_fun] = {
        M.i_dont_think_so,
        M.i_dont_know_anyone,
    },
    [M.q_looking_forward_to_party] = {
        M.not_really,
        M.i_dont_know_anyone,
        M.i_want_to_stay,
    },
}

m.load = function()
    connections = {}
    greetings = {}
end

m.safe = function(heard)
    print('[knowledge.safe] ' .. heard)
    local res = safeDialog[heard]
    if res ~= nil then
        return res
    else
        return { M.silence }
    end
end

m.learn = function(heard, in_response_to)
    if in_response_to == nil or in_response_to == '' then
        print('[knowledge] Learnt a new greeting: ' .. heard)
        table.insert(greetings, heard)
    else
        if connections[in_response_to] == nil then
            print('[knowledge] Learnt to respond to \'' .. in_response_to .. '\' with \'' .. heard .. '\' ')
            connections[in_response_to] = { heard }
        elseif not has_value(connections[in_response_to], heard) then
            print('[knowledge] Learnt to respond to \'' .. in_response_to .. '\' with \'' .. heard .. '\' ')
            table.insert(connections[in_response_to], heard)
        else
            print('[knowledge] Already knew how to respond to \'' .. in_response_to .. '\' with \'' .. heard .. '\' ')
        end
    end
end

m.recall = function(heard)
    if heard == nil or heard == '' then
        if #greetings > 0 then
            return greetings
        else
            return { M.silence }
        end
    end

    if connections[heard] ~= nil then
        return connections[heard]
    else
        return { M.silence }
    end
end

return m