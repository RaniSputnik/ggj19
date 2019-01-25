R = {}
R.fonts = {}

GAME_SPEED = 10


other_speak = {
    full_speech = 'Hello, nice to meet you!',
    current_pos = 0
}

other_speak.update = function(dt)
    local s = other_speak
    s.current_pos = s.current_pos + dt * GAME_SPEED
    if s.current_pos >= string.len(s.full_speech) then
        s.current_speech = s.full_speech
    else
        s.current_speech = string.sub(s.full_speech, 0, s.current_pos)
    end
    return s
end

other_speak.draw = function()
    local s = other_speak
    love.graphics.setFont(R.fonts.speech)
    love.graphics.print(other_speak.current_speech, 100, 200)
end

state = other_speak

function love.load()
    R.fonts.speech = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 32, "normal")
end

function love.update(dt)
    state = state.update(dt)
end

function love.draw()
    state.draw()
end