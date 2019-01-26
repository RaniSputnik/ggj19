local m = {}

-- Events

local function show_friendships()
    hud_show_friendship = true
end

-- Speaking

END_CONVERSATION = '</>'

m.say = function(txt, ev)
    return function()
        return txt, ev
    end
end

m.say_friendship = function()
    return m.say(M.maybe_youll_make_a_friend, show_friendships)
end

m.end_conversation = function()
    return m.say('', END_CONVERSATION)
end

return m