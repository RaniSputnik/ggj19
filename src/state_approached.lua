-- The approached state is when the player is frozen while another
-- character approaches them.

return function(params)
    local state = {
        target = params.target,
    }

    state.update = function(input, dt)
        local px, py = world.player:getPos()
        local tx, ty = state.target:getPos()

        -- TODO a* to determine path to player

        local synthesized_input = {
            left = false,
            right = false,
            up = false,
            down = false,
        }
        local hor = px - tx
        local ver = py - ty
        if hor > 0 then synthesized_input.right = true
        elseif hor < 0 then synthesized_input.left = true
        elseif ver > 0 then synthesized_input.down = true
        elseif ver < 0 then synthesized_input.up = true
        end

        state.target:update(synthesized_input, dt)
        if state.target:facing() == world.player then
            return state_speak({ speaker = state.target, speech = 'TODO: Ha! I approached you!' })
        end

        return state
    end

    state.draw = function()
        world:draw()
    end

    return state
end