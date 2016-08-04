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
end
