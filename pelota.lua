Pelota = {}

function Pelota:nuevo(imagen)
  local w, h = image:getDimensions()
  propiedades = {
    x = 0,
    y = 0,
    ancho = w,
    alto = h,
    drawable = imagen
  }
  self.__index = self
  return setmetatable (propiedades,self)
end

function Pelota:dibujar()
  love.graphics.draw(self.drawable, self.x, self.y, 0, 1, 1, self.ancho / 2, self.alto / 2)
end

function Pelota:actualizar(dt)
end
