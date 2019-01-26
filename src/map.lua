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

function map:isFree(cellx, celly)
    if cellx < 1 or cellx > self.grid_width then return false end
    if celly < 1 or celly > self.grid_height then return false end
    return true
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

return map