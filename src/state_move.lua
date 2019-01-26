-- The move state is where the player is freely moving

return function(params)
    local state = {}

    state.update = function(input, dt)
        -- TODO: Loop over all characters
        world.player:update(input, dt)

        local t = world:any_triggers()
        if t ~= nil then
            return state_approached({ target = t.character })
        end

        local other = world.player:facing()
        if other ~= nil and input.talk_pressed then
            return state_respond({ other = other, heard = '' })
        end

        return state
    end

    state.draw = function()
        world:draw()
    end

    return state
end