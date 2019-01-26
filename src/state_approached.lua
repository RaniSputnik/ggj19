-- The approached state is when the player is frozen while another
-- character approaches them.

return function(params)
    local state = {
        target = params.target,
        wait_before_move = 0,
        wait_before_talk = 0,
    }

    state.update = function(input, dt)
        state.wait_before_move = state.wait_before_move + dt
        if state.wait_before_move < 5 then
            return state
        end

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
        if ver > 0 then synthesized_input.down = true
        elseif ver < 0 then synthesized_input.up = true
        elseif hor > 0 then synthesized_input.right = true
        elseif hor < 0 then synthesized_input.left = true
        end

        state.target:update(synthesized_input, dt)
        if state.target:facing() == world.player then
            state.wait_before_talk = state.wait_before_talk + dt
            if state.wait_before_talk > 15 then
                return state_speak({ speaker = state.target })
            end
        end

        return state
    end

    state.draw = function()
        world:draw()
    end

    return state
end