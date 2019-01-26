-- The speak state is where a NPC reads their dialog

return function(params)
    if params.heard ~= nil then
        params.speech = params.speaker[params.heard]
    end

    local state = {
        speaker = params.speaker,
        full_speech = params.speech,
        current_speech = "",
        current_pos = 0
    }

    state.update = function(input, dt)
        local total_speech_length = string.len(state.full_speech)

        -- We have already shown all of the text
        if state.current_pos >= total_speech_length then
            return state_respond({ other = state.speaker, heard = state.full_speech })
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
        love.graphics.print(state.current_speech, LAYOUT_HEARD_X, LAYOUT_HEARD_Y)
    end

    return state
end