return function()
    local input = {
        continue = false,
        continue_pressed = false,
        restart = false,
        restart_pressed = false
    }

    input.update = function()
        local was_continue = input.continue
        local was_restart = input.restart

        input.continue = love.keyboard.isDown('space')
        input.restart = love.keyboard.isDown('r')

        input.continue_pressed = not was_continue and input.continue
        input.restart_pressed = not was_restart and input.restart
    end

    return input
end