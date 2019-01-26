-- The move state is where the player is freely moving

RIGHT = 1
DOWN = 2
LEFT = 3
UP = 4

local player = character.create(8, 15, RED)
local alice = character.create(1, 1, GREEN)

-- STATE

return function(params)
    local state = {}

    state.update = function(input, dt)
        player:update(input, dt)

        return state
    end

    state.draw = function()
        local map_width = map:getWidth()
        local map_height = map:getHeight()
        local left = (love.graphics.getWidth() - map_width) / 2
        local top = (love.graphics.getHeight() - map_height) / 2

        love.graphics.push()
        love.graphics.translate(left, top)

        love.graphics.setColor(WHITE)
        map:draw()
        player:draw()
        alice:draw()

        love.graphics.pop()
    end

    return state
end