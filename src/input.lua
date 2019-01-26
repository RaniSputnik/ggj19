return function()
    local input = {
        up = false,
        up_pressed = false,
        down = false,
        down_pressed = false,
        left = false,
        right = false,
        continue = false,
        continue_pressed = false,
        restart = false,
        restart_pressed = false
    }

    input.update = function()
        local was_up = input.up
        local was_down = input.down
        local was_continue = input.continue
        local was_restart = input.restart

        input.up = love.keyboard.isDown('up')
        input.down = love.keyboard.isDown('down')
        input.left = love.keyboard.isDown('left')
        input.right = love.keyboard.isDown('right')
        input.continue = love.keyboard.isDown('space')
        input.restart = love.keyboard.isDown('r')

        input.up_pressed = not was_up and input.up
        input.down_pressed = not was_down and input.down
        input.continue_pressed = not was_continue and input.continue
        input.restart_pressed = not was_restart and input.restart
    end

    return input
end