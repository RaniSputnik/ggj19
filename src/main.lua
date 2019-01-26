R = {}
R.fonts = {}

state_speak = require('state_speak')
state_respond = require('state_respond')

GAME_SPEED = 10
LAYOUT_HEARD_X = 32
LAYOUT_HEARD_Y = 200

function love.load()
    R.fonts.speech = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 32, "normal")

    input = require('input')()
    current_state = state_speak({ speech = 'Hello, nice to meet you!' })
end

function love.update(dt)
    input.update()
    current_state = current_state.update(input, dt * GAME_SPEED)

    if input.restart_pressed then
        return love.load()
    end
end

function love.draw()
    current_state.draw()
end

-- DEBUGGING

function love.keypressed(key, u)
    if key == "lctrl" then debug.debug() end
end