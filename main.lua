R = {}
R.fonts = {}

GAME_SPEED = 10

state_speak = require('state_speak')

state = state_speak({ speech = 'Hello, nice to meet you!' })

function love.load()
    R.fonts.speech = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 32, "normal")
end

function love.update(dt)
    state = state.update(dt * GAME_SPEED)
end

function love.draw()
    state.draw()
end