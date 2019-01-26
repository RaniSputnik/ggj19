-- The move state is where the player is freely moving

local white = {1,1,1}
local red = {1,0,0}

-- MAP

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

-- PLAYER

local player = {
    x = 0,
    y = 0,
    pos = { 0, 0 },
    goal = { 0, 0 },
    moving = false,
    color = red,
}

local function clamp(x, maxval, minval)
    return math.max(math.min(x, maxval), minval)
end

function player:update(input, dt)
    if not self.moving then
        local hor = (input.right and 1 or 0) - (input.left and 1 or 0)
        local ver = (input.down and 1 or 0) - (input.up and 1 or 0)
        if hor ~= 0 and ver ~= 0 then
            hor, ver = 0, 0
        end
        if hor ~= 0 then
            self.moving = true
            self.goal = {self.pos[1] + hor, self.pos[2]}
        end
        if ver ~= 0 then
            self.moving = true
            self.goal = {self.pos[1], self.pos[2] + ver }
        end
    end

    if self.moving then
        local speed = dt * 10
        local goal_x = self.goal[1] * map.cell_width
        local goal_y = self.goal[2] * map.cell_height
        local dx = goal_x - self.x
        local dy = goal_y - self.y

        if math.abs(dx) < speed and math.abs(dy) < speed then
            self.moving = false
            self.x = goal_x
            self.y = goal_y
            self.pos = {self.goal[1], self.goal[2]}
        end

        self.x = self.x + clamp(dx, speed, -speed)
        self.y = self.y + clamp(dy, speed, -speed)
    end
end

function player:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, 32, 32)
end

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

        love.graphics.setColor(white)
        map:draw()
        player:draw()

        love.graphics.pop()
    end

    return state
end