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

function map:isFree(gx, gy)
    if gx < 1 or gx > self.grid_width then return false end
    if gy < 1 or gy > self.grid_height then return false end
    return true
end

function map:getPos(gx, gy)
    return (gx-1) * self.cell_width, (gy-1) * self.cell_height
end

function map:draw()
    for gy = 1, self.grid_height do
        for gx = 1, self.grid_width do
            local xx, yy = self:getPos(gx, gy)
            love.graphics.rectangle("line", xx, yy, self.cell_width, self.cell_height)
        end
    end
end

return map