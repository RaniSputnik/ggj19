local m = {}

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

m.safe = function(heard)
    print('[knowledge.safe] ' .. heard)
    local res = safeDialog[heard]
    if res ~= nil then
        return res
    else
        return { M.silence }
    end
end

m.recall = function(heard)
    return { M.silence }
end

return m