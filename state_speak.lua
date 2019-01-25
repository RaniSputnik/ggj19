return function(params)
    local state = {
        full_speech = params.speech,
        current_pos = 0
    }

    state.update = function(dt)
        if state.current_pos >= string.len(state.full_speech) then
            state.current_speech = state.full_speech
        else
            state.current_pos = state.current_pos + dt
            state.current_speech = string.sub(state.full_speech, 0, state.current_pos)
        end
        return state
    end

    state.draw = function()
        love.graphics.setFont(R.fonts.speech)
        love.graphics.print(state.current_speech, 100, 200)
    end

    return state
end