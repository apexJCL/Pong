Nivel = {}
--[[

Sirve para describir el comportamiento del juego en cada modo o nivel

]]
function Nivel:nuevo ()
  propiedades = {
    actores = {}
  }
  self.__index = self
  return setmetatable(propiedades, self)
end

function Nivel:inicializar ()
end

function Nivel:agregarActor (actor)
  table.insert(self.actores, actor)
end

function Nivel:actualizar (dt)
  for k,actor in pairs(self.actores) do
    actor:actualizar(dt)
  end
end

function Nivel:dibujar ()
  for k,actor in pairs(self.actores) do
    actor:dibujar()
  end
  self:debug()
end

function Nivel:debug ()
  if not debug then
    return
  end
  love.graphics.setColor(51, 255, 236, 255)
  -- ejes
  love.graphics.line(0, love.graphics.getHeight() / 2, love.graphics.getWidth(), love.graphics.getHeight()/2)
  love.graphics.line(love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, love.graphics.getHeight())
  -- fin
  love.graphics.setColor(255, 255, 255, 255)
end
