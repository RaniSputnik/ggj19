require('math')

R = {}
R.fonts = {}

-- Game constants

GAME_SPEED = 20
LAYOUT_HEARD_X = 32
LAYOUT_HEARD_Y = 200

-- Colours

WHITE = {208/255,227/255,244/255}
OFF_WHITE = {195/255, 213/255, 229/255}
GREEN_1 = {80/255,111/255,84/255}
GREEN_2 = {45/255,84/255,50/255}
GREEN_3 = {60/255,90/255,65/255}
BLUE = {88/255,143/255,183/255}
BLACK = {26/255,29/255,2/255}

-- Load features

msg = require('msg')
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
    love.graphics.setBackgroundColor(BLACK)

    R.fonts.speech = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 32, "normal")
    R.fonts.speech_dana = love.graphics.newFont('assets/fonts/GentiumPlus-I.ttf', 32, "normal")
    R.fonts.hud = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 18, "light")

    hud_show_friendship = false
    objective_friends_count = 0

    knowledge.load()

    partner = {
        name = "Kian",
        greeting = M.q_looking_forward_to_party,
        responses = {
            [M.not_really] = speak.say_friendship(),
            [M.i_dont_think_so] = speak.say_friendship(),
            [M.i_dont_know_anyone] = speak.say_friendship(),
            [M.i_want_to_stay] = speak.say(M.q_it_might_be_fun),
        }
    }

    -- Create the world

    -- World map is needed in characters
    -- Gross, we could probably make that better
    world = { map = map.create() }

    local player = character.create("Player", 5, 14, BLUE, RIGHT)

    local alice = character.create("Alice", 8, 11, GREEN_1, DOWN)

    local alice_fed_up = function()
        alice.responses[M.silence] = speak.say(M.for_goodness_sake)
    end

    local alice_last_chance = function()
        alice.responses[M.silence] = speak.say(M.fine_suit_yourself)
        alice.responses[M.hi_finally_meet_you] = speak.say(M.oh_so_you_do_speak, alice_fed_up)
    end

    alice.greeting = M.hi_finally_meet_you
    alice.responses = {
        [M.silence] = speak.say(M.erm_hello_do_you_speak, alice_last_chance)
    }

    local bertrand = character.create("Bertrand", 2, 2, GREEN_2, RIGHT)
    bertrand.greeting = M.good_day
    bertrand.responses = {
        [M.hi_finally_meet_you] = speak.say(M.silence)
    }

    local amelia = character.create("Amelia", 4, 3, GREEN_3, LEFT)
    amelia.greeting = M.hi_finally_meet_you
    amelia.responses = {
        [M.hi_finally_meet_you] = speak.say(M.nice_to_meet_you_too),
        [M.oh_so_you_do_speak] = speak.say(M.yes_surprised),
    }

    world.player = player
    world.characters = { player, alice, bertrand, amelia }
    world.triggers = {
        trigger.create(alice, 5, 13, 11, 13),
        trigger.create(amelia, 6, 2, 6, 3),
    }

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
    current_state = state_speak({ speaker = partner })
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