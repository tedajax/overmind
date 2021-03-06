require 'input'
require 'game'
require 'log'
require 'camera'

function math.clamp(v, min, max)
    if v < min then
        return min
    elseif v > max then
        return max
    else
        return v
    end
end

function love.load()
    Screen = {}
    Screen.width = love.graphics.getWidth()
    Screen.height = love.graphics.getHeight()
    Screen.base_width = 1280
    Screen.base_height = 720

    Input = create_input()

    Input:add_axis("horizontal")
    Input:add_axis("vertical")

    Input:create_axis_binding("horizontal", "right", 1)
    Input:create_axis_binding("horizontal", "left", -1)
    Input:create_axis_binding("vertical", "up", -1)
    Input:create_axis_binding("vertical", "down", 1)

    Input:add_button("jump")
    Input:create_button_binding("jump", "z")

    Input:add_button("cancel")
    Input:create_button_binding("cancel", "x")

    Game = create_game()
    Game:init()

    Camera = create_camera()
    Camera.base_zoom = Screen.base_width / Screen.width
    Camera:look_at(0, 0)
    -- Camera:zoom_in(5)

    Log = create_log()
end

function love.update(dt)
    Game:update(dt)
    Input:update(dt)
    Log:update(dt)
    -- Camera:look_at(Game.player.position.x, Game.player.position.y)
end

function love.draw()
    Camera:push()
    Game:render()
    Camera:pop()
    Log:render()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    Input:on_key_down(key)
end

function love.keyreleased(key)
    Input:on_key_up(key)
end