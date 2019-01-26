require('math')

R = {}
R.fonts = {}

-- Game constants

GAME_SPEED = 10
LAYOUT_HEARD_X = 32
LAYOUT_HEARD_Y = 200

-- Colours

WHITE = {1,1,1}
RED = {1,0,0}
GREEN = {0,1,0}
BLUE = {0,0,1}
BLACK = {0,0,0}

-- Load features

M = require('msg')
speak = require('speak')
knowledge = require('knowledge')
map = require('map')
character = require('character')

-- Load game states

state_speak = require('state_speak')
state_respond = require('state_respond')
state_move = require('state_move')

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

    -- Create the world

    local player = character.create("Player", 2, 3, RED)
    local alice = character.create("Alice", 1, 1, GREEN)
    world = {
        player = player,
        characters = { player, alice },
    }

    function world:draw()
        local map_width = map:getWidth()
        local map_height = map:getHeight()
        local left = (love.graphics.getWidth() - map_width) / 2
        local top = (love.graphics.getHeight() - map_height) / 2

        love.graphics.push()
        love.graphics.translate(left, top)

        love.graphics.setColor(WHITE)
        map:draw()
        for i = 1, #self.characters do
            self.characters[i]:draw()
        end

        love.graphics.pop()
    end

    -- Setup input and state

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