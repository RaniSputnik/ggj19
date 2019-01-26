-- The move state is where the player is freely moving

return function(params)
    local state = {}

    state.update = function(input, dt)
        -- TODO: Loop over all characters
        world.player:update(input, dt)

        local other = world.player:facing()
        if other ~= nil and input.talk then
            return state_respond({ other = other, heard = '' })
        end

        return state
    end

    state.draw = function()
        world:draw()
    end

    return state
end