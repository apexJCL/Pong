debug = false

--[[
Aquí se cargan los datos del juego, entre otras cosas
]]
function love.load(arg)
  -- Cargar scripts de paleta y pelota
  require('pelota')
  require('paleta')
  require('particula')
  require('nivelBase')
  require('niveles/nivel0')
  require('niveles/nivel2')

  nivelActual = Nivel2:nuevo()
  nivelActual = Nivel2:inicializar()
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
