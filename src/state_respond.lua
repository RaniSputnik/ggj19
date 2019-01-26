-- The respond state is the opportunity for the player
-- to give a response to something an NPC said.

local function getResponses(other, heard)
    if other == dana then
        -- If we are speaking to dana, we can speak freely
        return knowledge.safe(heard)
    else
        -- Otherwise we must learn from others
        return knowledge.recall(heard)
    end
end

return function(params)
    local state = {
        other = params.other,
        heard = params.heard,
        responses = getResponses(params.other, params.heard),
        selection = 1
    }

    local texts = {}
    for i = 1, #state.responses do
        texts[i] = love.graphics.newText(R.fonts.speech, state.responses[i])
    end

    state.update = function(input, dt)
        if input.continue_pressed then
            return state_speak({
                speaker = state.other,
                heard = state.responses[state.selection]
            })
        end

        local net = (input.down_pressed and 1 or 0) - (input.up_pressed and 1 or 0)
        state.selection = state.selection + net
        if state.selection > #state.responses then state.selection = #state.responses end
        if state.selection < 1 then state.selection = 1 end

        return state
    end

    state.draw = function()
        love.graphics.setFont(R.fonts.speech)
        love.graphics.print(state.heard, LAYOUT_HEARD_X, LAYOUT_HEARD_Y)

        local pad = 32
        local text_height = 46
        local right = love.graphics.getWidth()-pad*2
        for i = 1, #texts do
            local txt = texts[i]
            local w = txt:getWidth()
            local top = 300+i*50
            local left = right - w
            local bottom = top + text_height

            love.graphics.draw(txt, left, top)
            if i == state.selection then
                love.graphics.line(left, bottom, right, bottom)
            end
        end
    end

    return state
end