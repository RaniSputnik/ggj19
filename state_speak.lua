local state_respond = require('state_respond')

return function(params)
    local state = {
        full_speech = params.speech,
        current_pos = 0
    }

    state.update = function(input, dt)
        local total_speech_length = string.len(state.full_speech)

        -- We have already shown all of the text
        if state.current_pos >= total_speech_length then
            return state_respond({ heard = state.full_speech })
        -- The player has used the 'continue' button
        elseif input.continue_pressed then
            state.current_pos = total_speech_length
            state.current_speech = state.full_speech
        -- The text is still slowly being revealed
        else
            state.current_pos = state.current_pos + dt
            state.current_speech = string.sub(state.full_speech, 0, state.current_pos)
        end

        return state
    end

    state.draw = function()
        love.graphics.setFont(R.fonts.speech)
        love.graphics.print(state.current_speech, PADDING, 200)
    end

    return state
end