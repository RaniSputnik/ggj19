-- The move state is where the player is freely moving

local player = character.create(2, 3, RED)
local alice = character.create(1, 1, GREEN)

local no_input = {
    left = false,
    right = false,
    up = false,
    down = false,
}

-- STATE

return function(params)
    local state = {}

    state.update = function(input, dt)
        -- TODO: Loop over all characters
        player:update(input, dt)
        alice:update(no_input, dt)

        local other = player:facing()
        if other ~= nil and input.talk then
            return state_respond({ other = other, heard = '' })
        end

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
         -- TODO: Loop over all characters
        player:draw()
        alice:draw()

        love.graphics.pop()
    end

    return state
end