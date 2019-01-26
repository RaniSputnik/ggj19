-- The move state is where the player is freely moving

return function(params)
    local state = {
        target = params.target,
    }

    state.update = function(input, dt)
        state.target:update()

        return state
    end

    state.draw = function()
        world:draw()
    end

    return state
end