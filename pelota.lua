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
    },
    velocidad_y = 200,
    velocidad_x = 200,
    direccion_x = 1,
    direccion_y = 1
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
  self:botar()
	self.y = self.y + (self.velocidad_y * dt) * self.direccion_y
  self.x = self.x + (self.velocidad_x * dt) * self.direccion_x
end


function Pelota:botar()
  if (self.y - self.alto / 2) <= 0 or (self.y + self.alto / 2) >= love.graphics.getHeight() then
		self.direccion_y = self.direccion_y * -1
	end
end

function Pelota:checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function Pelota:reiniciar()
  if self.x < 0 or self.x > love.graphics.getWidth()  then
    self.x = love.graphics.getHeight() / 2
    self.direccion_x = self.direccion_x * -1
    return self.direccion_x
  end
  return 0
end

function Pelota:pegando(paletas)
  -- Coordenadas absolutas para la caja de choque
  local sax, say = self:absCoord()
  for i,paleta in ipairs(paletas) do
    -- Coordenadas absolutas para la caja de choque de la paleta
    local pax, pay = paleta:getAbsCoord()
    if self:checkCollision(sax, say, self.ancho,self.alto,
    pax,pay,paleta.ancho,paleta.alto) then
      self.direccion_x = self.direccion_x * -1
      return true
    end
  end
  return false
end

function Pelota:aumentarVelocidad (dt, incremento)
  local inc = (incremento * dt)
  self.velocidad_x, self.velocidad_y = self.velocidad_x + inc, self.velocidad_y + (inc * 0.5)
end

function Pelota:debug ()
  if not debug then
    return
  end
  love.graphics.setColor(255, 25, 55, 255)
  -- ejes
  love.graphics.line(self.x - self.ancho / 2, self.y, self.x + self.ancho / 2 , self.y)
  love.graphics.line(self.x, self.y - self.alto / 2, self.x, self.y + self.alto / 2)
  -- velocidad
  love.graphics.setColor(255, 255, 128, 255)
  love.graphics.print("vx: "..self.velocidad_x, self.x + self.ancho, self.y + self.alto)
  love.graphics.print("vy: "..self.velocidad_y, self.x + self.ancho, self.y + self.alto + 25)

  --fin
  love.graphics.setColor(255, 255, 255, 255)
end

function Pelota:absCoord ()
  local x, y = self.x - self.ancho / 2, self.y - self.alto / 2
  return x, y
end
