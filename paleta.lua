Paleta = {}
--[[

Crea una nueva paleta
Recibe:
+ Imagen : Sprite a dibujar
+ px : Posición en X
+ teclaUp : Tecla con la cual la paleta irá hacia arriba
+ teclaDown: Tecla con la cual irá hacía abajo
+ limSup y limInf : Establece limites para ir hacia arriba o abajo, sino se
  - especifica con el tamaño de la pantalla

]]
function Paleta:nuevo(imagen, px, teclaUp, teclaDown, limSup, limInf, color)
  -- Local porque sólo se usará aquí, no en otro lado
  local w, h = imagen:getDimensions()
  local default_color = {
    r = 255,
    g = 255,
    b = 255,
    a = 255
  }
  propiedades = {
    x = px + w/2,
    y = 0,
    ancho = w,
    alto = h,
    velocidad = 200,
    -- Tecla para moverse hacía arriba
    tUp = teclaUp,
    -- Tecla para moverse hacía abajo
    tDown = teclaDown,
    -- El sprite de la paleta
    drawable = imagen,
    minY = limSup or h/2,
    maxY = love.graphics.getHeight() - h/2,
    c = color or default_color
  }
  self.__index = self
  return setmetatable(propiedades, self)
end

function Paleta:setColor (color)
  self.c = color
end

function Paleta:dibujar()
  -- Cambia el color
  love.graphics.setColor(self.c.r, self.c.g, self.c.b, self.c.a)
  love.graphics.draw(self.drawable, self.x, self.y, 0, 1, 1, self.ancho / 2, self.alto / 2)
  -- Restauramos el color de dibujado
  love.graphics.setColor(255, 255, 255, 255)

  -- debug
  if debug then
    self:debug()
  end
end

function Paleta:actualizar(dt)

  if love.keyboard.isDown (self.tDown) and (self.y ) <= self.maxY then
    self.y = self.y + (self.velocidad * dt)
  end

  if love.keyboard.isDown (self.tUp) and self.y >= self.minY then
    self.y = self.y - (self.velocidad * dt)
  end

end

function Paleta:debug ()
  -- eje x
  love.graphics.line(self.x, self.y , love.graphics.getWidth(), self.y)
  -- velocidad
  if self.x < 0 then
    local vx = self.ancho
  elseif self.x > love.graphics.getWidth() then
    local vx = self.x - self.ancho / 2
  end
  local vx = self.x + self.ancho
  love.graphics.print("v: "..self.velocidad, vx, self.y)
end
