-- The speak state is where a NPC reads their dialog

return function(params)
    local speech = params.speaker.greeting
    if params.heard ~= nil then
        local res = params.speaker.responses[params.heard]
        if res ~= nil then
            speech, params.event = res()
        else
            speech = M.silence
            params.event = nil
        end
    end

    if params.speaker ~= dana then
        knowledge.learn(speech, params.heard)
    end

    local state = {
        speaker = params.speaker,
        full_speech = speech,
        event = params.event,
        current_speech = "",
        current_pos = 0
    }

    state.update = function(input, dt)
        -- TODO: This is so fricken hacky, definitely
        -- got some structural issues here
        if state.full_speech == '' then
            return state_move()
        end

        local total_speech_length = string.len(state.full_speech)

        -- We have already shown all of the text
        if state.current_pos >= total_speech_length then
            if state.event ~= nil then
                if state.event == END_CONVERSATION then
                    return state_respond({
                        other = state.speaker,
                        heard = state.full_speech,
                        prevent_response = true,
                    })
                end
                state.event()
            end
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