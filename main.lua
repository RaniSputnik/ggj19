R = {}
R.fonts = {}

function love.load()
    R.fonts.speech = love.graphics.newFont('assets/fonts/GentiumPlus-R.ttf', 32, "normal")
end

function love.update(dt)

end

function love.draw()
	love.graphics.setFont(R.fonts.speech)
	love.graphics.print("Hello world!", 100, 200)
end