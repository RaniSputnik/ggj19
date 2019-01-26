-- The move state is where the player is freely moving

return function(params)
    local state = {
        wait_to_talk_to = nil,
        wait_to_talk = 0,
    }

    state.update = function(input, dt)
        -- TODO: Maybe all of this should be another state
        -- I just couldn't think of a good enough name.
        -- Existing names are already confusing enough.
        if state.wait_to_talk_to then
            state.wait_to_talk = state.wait_to_talk + dt
            state.wait_to_talk_to:turnToFace(world.player:getPos())

            if state.wait_to_talk > 5 then
                return state_respond({ other = state.wait_to_talk_to, heard = '' })
            end

            -- No other player input
            return state
        end

        -- TODO: Loop over all characters
        world.player:update(input, dt)

        local t = world:any_triggers()
        if t ~= nil then
            return state_approached({ target = t.character })
        end

        local other = world.player:facing()
        if other ~= nil and input.talk_pressed then
            state.wait_to_talk_to = other
            state.waiting_to_talk = true
        end

        return state
    end

    state.draw = function()
        world:draw()
    end

    return state
end