--[[
Aquí se cargan los datos del juego, entre otras cosas
]]
function love.load(arg)
  -- Cargar scripts de paleta y pelota
  require('pelota')
  require('paleta')
  -- Cargar la imagen de la paleta
  imagen_paleta_a = love.graphics.newImage('assets/paleta_a.png')
  -- Color paleta 1
  color = {
    r = 16,
    g = 16,
    b = 214,
    a = 128
  }
  -- Crear la paleta
  paleta_a = Paleta:nuevo(imagen_paleta_a, 0, 'w', 's')
  paleta_a:setColor(color)
end

--[[
Aquí se actualiza el juego
]]
function love.update(dt)
  paleta_a:actualizar(dt)
end

--[[
Aquí se dibuja el juego
]]
function love.draw()
  paleta_a:dibujar()
end
