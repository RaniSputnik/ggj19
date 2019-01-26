local m = {}

m.create = function(character, left, top, right, bottom)
    local t = {
        character = character,
        left = left,
        top = top,
        right = right,
        bottom = bottom,
        triggered = false,
    }

    function t:getCharacter()
        return self.character
    end

    function t:test()
        if self.triggered then return false end
        local px, py = world.player:getPos()
        if px >= self.left and px <= self.right
        and py >= self.top and py <= self.bottom then
            self.triggered = true
            return true
        end

        return false
    end

    return t
end

return m