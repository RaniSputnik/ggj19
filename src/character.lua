RIGHT = 1
DOWN = 2
LEFT = 3
UP = 4

local m = {}

local function clamp(x, maxval, minval)
    return math.max(math.min(x, maxval), minval)
end

local dir_offset = {
    [RIGHT] = {1, 0},
    [DOWN] = {0, 1},
    [LEFT] = {-1, 0},
    [UP] = {0, -1},
}

m.create = function(name, gridx, gridy, color)
    local xx, yy = map:getPos(gridx, gridy)

    local c = {
        name = name,
        x = xx,
        y = yy,
        pos = { gridx, gridy },
        goal = { gridx, gridy },
        moving = false,
        color = color,
        direction = RIGHT
    }

    map:occupy(c, gridx, gridy)

    function c:update(input, dt)
        if not self.moving then
            local hor = (input.right and 1 or 0) - (input.left and 1 or 0)
            local ver = (input.down and 1 or 0) - (input.up and 1 or 0)
            if hor ~= 0 and ver ~= 0 then
                hor, ver = 0, 0
            end
            if hor ~= 0 then
                if hor > 0 then
                    self.direction = RIGHT
                else
                    self.direction = LEFT
                end
                local gx, gy = self.pos[1] + hor, self.pos[2]
                if map:isFree(gx, gy) then
                    self.moving = true
                    self.goal = {gx, gy}
                    map:occupy(self, gx, gy)
                end
            end
            if ver ~= 0 then
                if ver > 0 then
                    self.direction = DOWN
                else
                    self.direction = UP
                end
                local gx, gy = self.pos[1], self.pos[2] + ver
                if map:isFree(gx, gy) then
                    self.moving = true
                    self.goal = {gx, gy}
                    map:occupy(self, gx, gy)
                end
            end
        end

        if self.moving then
            local speed = dt * 10
            local goal_x = (self.goal[1]-1) * map.cell_width
            local goal_y = (self.goal[2]-1) * map.cell_height
            local dx = goal_x - self.x
            local dy = goal_y - self.y

            if math.abs(dx) < speed and math.abs(dy) < speed then
                self.moving = false
                self.x = goal_x
                self.y = goal_y
                map:release(self, self.pos[1], self.pos[2])
                self.pos = {self.goal[1], self.goal[2]}
            end

            self.x = self.x + clamp(dx, speed, -speed)
            self.y = self.y + clamp(dy, speed, -speed)
        end
    end

    function c:draw()
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", self.x, self.y, 32, 32)

        love.graphics.setColor(BLACK)
        if self.direction == RIGHT then
            love.graphics.rectangle("fill", self.x+20, self.y+10, 12, 12)
        elseif self.direction == DOWN then
            love.graphics.rectangle("fill", self.x+10, self.y+20, 12, 12)
        elseif self.direction == LEFT then
            love.graphics.rectangle("fill", self.x, self.y+10, 12, 12)
        elseif self.direction == UP then
            love.graphics.rectangle("fill", self.x+10, self.y, 12, 12)
        end
    end

    function c:facing()
        if self.moving then return nil end
        local o = dir_offset[self.direction]
        gx, gy = self.pos[1] + o[1], self.pos[2] + o[2]
        return map:occupant(gx, gy)
    end

    return c
end

return m