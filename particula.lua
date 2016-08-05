Particula = {}


--[[
  Crea una nueva partícula con la imagen dada.
  Recibe 2 parámetros:
  imagen - Imagen a usar para la partícula
  buffer - Cantidad de partículas máximas a emitir
]]
function Particula:nuevo(imagen, buffer, color)
  propiedades  = {
    sistema = love.graphics.newParticleSystem(imagen, buffer),
    x = 0,
    y = 0,
    buffer = buffer,
    c = color or {
      r = 255,
      g = 255,
      b = 255,
      a = 255
    }
  }
  self.__index = self
  return setmetatable(propiedades, self)
end

--[[
  Inicializa el sistema de partículas.
  Configuración por defecto:
    - Transparencia 100 a 0 (se van desvaneciendo)
    - Tiempo de vida: 0.5 a 1s
  Recibe 4 parámetros:
  xmin - Velocidad mínima en x
  xmax - Velocidad máxima en x
  ymin - Velocidad mínima en y
  ymax - Velocida máxima en y

  Estos sirven para configurar la aceleración lineal
]]
function Particula:inicializar(xmin, xmax, ymin, ymax)
  -- Transparencia
  self.sistema:setColors(255, 255, 255, 255, 255, 255, 255, 0)
  -- Tiempo de vida
  self.sistema:setParticleLifetime(0.1, 1)
  -- Velocidad
  self.sistema:setLinearAcceleration(xmin, ymin, xmax, ymax)
end

--[[
  Actualiza el sistema de particulas, mandar llamar en love.update(dt)
  Recibe 3 parámetros:
  dt - Delta Time
  px - Posición X para el emisor antes de emitir
  py - Posición en Y para el emisor antes de emitir
]]
function Particula:actualizar(dt, px, py)
  self.sistema:setPosition(px, py)
  self.sistema:update(dt)
end

--[[
  Dibuja el sistema de partículas en pantalla, llamar en love.draw()
]]
function Particula:dibujar()
  love.graphics.setColor(self.c.r, self.c.g, self.c.b, self.c.a)
  love.graphics.draw(self.sistema, self.x, self.y, 0, 1, 1)
  love.graphics.setColor(255, 255, 255, 255)
end


--[[
  Emite la cantidad de partículas
]]
function Particula:emitir (cantidad)
  self.sistema:emit(cantidad)
end
