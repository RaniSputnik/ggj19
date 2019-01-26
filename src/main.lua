require('math')

R = {}
R.fonts = {}

M = require('msg')
speak = require('speak')
knowledge = require('knowledge')

state_speak = require('state_speak')
state_respond = require('state_respond')
state_move = require('state_move')

GAME_SPEED = 10
LAYOUT_HEARD_X = 32
LAYOUT_HEARD_Y = 200

function love.load()
    R.fonts.speech = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 32, "normal")
    R.fonts.hud = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 18, "light")

    hud_show_friendship = false
    objective_friends_count = 0

    dana = {
        [M.not_really] = speak.say_friendship(),
        [M.i_dont_think_so] = speak.say_friendship(),
        [M.i_dont_know_anyone] = speak.say_friendship(),
        [M.i_want_to_stay] = speak.say(M.q_it_might_be_fun),
        [M.groan] = speak.end_conversation(),
        [M.fine] = speak.end_conversation(),
        [M.your_right] = speak.end_conversation(),
    }

    input = require('input')()
    current_state = state_speak({ speaker = dana, speech = M.q_looking_forward_to_party })
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

    if hud_show_friendship then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(R.fonts.hud)
        love.graphics.print("Friends: " .. objective_friends_count, 16, 4)
    end
end

-- DEBUGGING

function love.keypressed(key, u)
    --if key == "lctrl" then debug.debug() end
end