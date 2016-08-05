Pelota = {}

function Pelota:nuevo(imagen, color)
  local w, h = imagen:getDimensions()
  propiedades = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
    ancho = w,
    alto = h,
    drawable = imagen,
    c = color or {
      r = 255,
      g = 255,
      b = 255,
      a = 255
    }
  }
  self.__index = self
  return setmetatable (propiedades,self)
end

function Pelota:dibujar()
  love.graphics.setColor(self.c.r, self.c.g, self.c.b, self.c.a)
  love.graphics.draw(self.drawable, self.x, self.y, 0, 1, 1, self.ancho / 2, self.alto / 2)
  self:debug()
end

function Pelota:actualizar(dt)
end

function Pelota:debug ()
  if not debug then
    return
  end
  love.graphics.setColor(255, 25, 55, 255)
  -- ejes
  love.graphics.line(self.x - self.ancho / 2, self.y, self.x + self.ancho / 2 , self.y)
  love.graphics.line(self.x, self.y - self.alto / 2, self.x, self.y + self.alto / 2)

  --fin
  love.graphics.setColor(255, 255, 255, 255)
end
