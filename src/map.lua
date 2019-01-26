local m = {}

m.create = function()
    local map = {
        grid_width = 15,
        grid_height = 15,
        cell_width = 32,
        cell_height = 32,
        occupants = {},
        tiles = {
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,
            0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,
            0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,
            0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,
            0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,
        }
    }

    function map:index(gx, gy)
        return gx + (gy-1) * self.grid_width
    end

    function map:getWidth()
        return self.grid_width * self.cell_width
    end

    function map:getHeight()
        return self.grid_height * self.cell_height
    end

    function map:isFree(gx, gy)
        if not self:isValidPosition(gx,gy) then return false end
        local i = self:index(gx, gy)
        if self.tiles[i] == 0 then return false end
        return self.occupants[i] == nil
    end

    function map:isValidPosition(gx, gy)
        if gx < 1 or gx > self.grid_width then return false end
        if gy < 1 or gy > self.grid_height then return false end
        return true
    end

    function map:occupy(inst, gx, gy)
        if inst == nil then return false end
        if not self:isValidPosition(gx,gy) then return false end

        local i = self:index(gx, gy)
        self.occupants[i] = inst
        return true
    end

    function map:occupant(gx, gy)
        if not self:isValidPosition(gx,gy) then return nil end
        local i = self:index(gx, gy)
        return self.occupants[i]
    end

    function map:release(inst, gx, gy)
        if inst == nil then return false end
        if not self:isValidPosition(gx,gy) then return false end

        local i = self:index(gx, gy)
        if not self.occupants[i] == inst then return false end
        self.occupants[i] = nil
        return true
    end

    function map:getPos(gx, gy)
        return (gx-1) * self.cell_width, (gy-1) * self.cell_height
    end

    function map:draw()
        for gy = 1, self.grid_height do
            for gx = 1, self.grid_width do
                local xx, yy = self:getPos(gx, gy)
                local i = self:index(gx, gy)
                if self.tiles[i] > 0 then
                    local draw_mode = "line"
                    if self.occupants[i] ~= nil then draw_mode = "fill" end
                    love.graphics.rectangle(draw_mode, xx, yy, self.cell_width, self.cell_height)
                end
            end
        end
    end

    return map
end

return m