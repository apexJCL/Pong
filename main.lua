debug = false

--[[
Aquí se cargan los datos del juego, entre otras cosas
]]
function love.load(arg)
  -- Cargar scripts de paleta y pelota
  require('pelota')
  require('paleta')
  require('nivelBase')
  require('niveles/nivel0')

  nivelActual = Nivel0:inicializar()
end

--[[
Aquí se actualiza el juego
]]
function love.update(dt)
  nivelActual:actualizar(dt)
end

--[[
Aquí se dibuja el juego
]]
function love.draw()
  nivelActual:dibujar()
end
