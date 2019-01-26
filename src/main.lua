require('math')

R = {}
R.fonts = {}

-- Game constants

GAME_SPEED = 20
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
trigger = require('trigger')

-- Load game states

state_speak = require('state_speak')
state_respond = require('state_respond')
state_move = require('state_move')
state_approached = require('state_approached')

function love.load()
    R.fonts.speech = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 32, "normal")
    R.fonts.speech_dana = love.graphics.newFont('assets/fonts/GentiumPlus-I.ttf', 32, "normal")
    R.fonts.hud = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 18, "light")

    hud_show_friendship = false
    objective_friends_count = 0

    knowledge.load()

    dana = {
        name = "Dana",
        greeting = M.q_looking_forward_to_party,
        responses = {
            [M.not_really] = speak.say_friendship(),
            [M.i_dont_think_so] = speak.say_friendship(),
            [M.i_dont_know_anyone] = speak.say_friendship(),
            [M.i_want_to_stay] = speak.say(M.q_it_might_be_fun),
            [M.groan] = speak.end_conversation(),
            [M.fine] = speak.end_conversation(),
            [M.your_right] = speak.end_conversation(),
        }
    }

    -- Create the world

    -- World map is needed in characters
    -- Gross, we could probably make that better
    world = { map = map.create() }

    local player = character.create("Player", 8, 15, RED, UP)

    local alice = character.create("Alice", 8, 11, GREEN, DOWN)

    local alice_fed_up = function()
        alice.responses[M.silence] = speak.say(M.for_goodness_sake, END_CONVERSATION)
    end

    local alice_last_chance = function()
        alice.responses[M.silence] = speak.say(M.fine_suit_yourself, END_CONVERSATION)
        alice.responses[M.hi_finally_meet_you] = speak.say(M.oh_so_you_do_speak, alice_fed_up)
    end

    alice.greeting = M.hi_finally_meet_you
    alice.responses = {
        [M.silence] = speak.say(M.erm_hello_do_you_speak, alice_last_chance)
    }

    local bertrand = character.create("Bertrand", 2, 2, BLUE, RIGHT)
    bertrand.greeting = M.good_day
    bertrand.responses = {
        [M.hi_finally_meet_you] = speak.say(M.silence)
    }

    world.player = player
    world.characters = { player, alice, bertrand }
    world.triggers = { trigger.create(alice, 5, 13, 11, 13) }

    function world:any_triggers()
        for i = 1, #self.triggers do
            local t = self.triggers[i]
            if t:test() then return t end
        end
        return nil
    end

    function world:draw()
        local map_width = self.map:getWidth()
        local map_height = self.map:getHeight()
        local left = (love.graphics.getWidth() - map_width) / 2
        local top = (love.graphics.getHeight() - map_height) / 2

        love.graphics.push()
        love.graphics.translate(left, top)

        love.graphics.setColor(WHITE)
        self.map:draw()
        for i = 1, #self.characters do
            self.characters[i]:draw()
        end

        love.graphics.pop()
    end

    -- Setup input and state

    input = require('input')()
    current_state = state_speak({ speaker = dana })
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