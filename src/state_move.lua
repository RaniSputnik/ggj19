-- The move state is where the player is freely moving

local map = {
    grid_width = 16,
    grid_height = 16,
    cell_width = 32,
    cell_height = 32,
}

function map:getWidth()
    return self.grid_width * self.cell_width
end

function map:getHeight()
    return self.grid_height * self.cell_height
end

return function(params)
    local state = {}

    state.update = function(input, dt)
        return state
    end

    state.draw = function()
        local map_width = map:getWidth()
        local map_height = map:getHeight()

        local left = (love.graphics.getWidth() - map_width) / 2
        local top = (love.graphics.getHeight() - map_height) / 2

        for gy = 0, map.grid_height-1 do
            for gx = 0, map.grid_width-1 do
                local xx = left + gx * map.cell_width
                local yy = top + gy * map.cell_height
                love.graphics.rectangle("line", xx, yy, map.cell_width, map.cell_height)
            end
        end
    end

    return state
end