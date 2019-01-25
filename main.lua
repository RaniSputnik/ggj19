R = {}
R.fonts = {}

GAME_SPEED = 10
PADDING = 32

state_speak = require('state_speak')

state = state_speak({ speech = 'Hello, nice to meet you!' })

input = {
    continue = false,
    continue_pressed = false
}

function love.load()
    R.fonts.speech = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 32, "normal")
end

function love.update(dt)
    local was_continue = input.continue
    input.continue = love.keyboard.isDown('space')
    input.continue_pressed = not was_continue and input.continue

    state = state.update(input, dt * GAME_SPEED)
end

function love.draw()
    state.draw()
end