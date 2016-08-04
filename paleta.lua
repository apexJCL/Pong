Paleta = {}

function Paleta:nuevo(imagen, px, teclaUp, teclaDown)
  -- Local porque sólo se usará aquí, no en otro lado
  local w, h = imagen:getDimensions()
  propiedades = {
    x = px,
    y = 0,
    ancho = w,
    alto = h,
    velocidad = 150,
    -- Tecla para moverse hacía arriba
    tUp = teclaUp,
    -- Tecla para moverse hacía abajo
    tDown = teclaDown,
    -- El sprite de la paleta
    drawable = imagen
  }
  self.__index = self
  return setmetatable(propiedades, self)
end

function Paleta:dibujar()
  love.graphics.draw(self.drawable, self.x, self.y, 0, 1, 1, self.ancho / 2, self.alto / 2)
end

function Paleta:actualizar(dt)

  if love.keyboard.isDown (self.tDown) then
    self.y = self.y - (self.velocidad * dt)
  end

  if love.keyboard.isDown (self.tUp) then
    self.y = self.y + (self.velocidad * dt)
  end

end
