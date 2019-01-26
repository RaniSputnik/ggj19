-- The move state is where the player is freely moving

local white = {1,1,1}
local red = {1,0,0}

local player = {
    x = 0,
    y = 0,
    gx = 0,
    gy = 0,
    color = red,
}

function player:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, 32, 32)
end

local map = {
    grid_width = 15,
    grid_height = 15,
    cell_width = 32,
    cell_height = 32,
}

function map:getWidth()
    return self.grid_width * self.cell_width
end

function map:getHeight()
    return self.grid_height * self.cell_height
end

function map:draw()
    for gy = 0, self.grid_height-1 do
        for gx = 0, self.grid_width-1 do
            local xx = gx * self.cell_width
            local yy = gy * self.cell_height
            love.graphics.rectangle("line", xx, yy, self.cell_width, self.cell_height)
        end
    end
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

        love.graphics.push()
        love.graphics.translate(left, top)

        love.graphics.setColor(white)
        map:draw()
        player:draw()

        love.graphics.pop()
    end

    return state
end