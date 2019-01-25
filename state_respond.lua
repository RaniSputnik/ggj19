local knowledge = require('knowledge')

return function(params)
    local state = {
        heard = params.heard,
        responses = knowledge.recall(params.heard)
    }

    state.update = function(input, dt)
        return state
    end

    state.draw = function()
        love.graphics.setFont(R.fonts.speech)
        love.graphics.print(state.heard, PADDING, 200)

        for i = 1, #state.responses do
            love.graphics.printf(state.responses[i], PADDING, 300+i*50, love.graphics.getWidth()-PADDING*2, "right")
        end
    end

    return state
end