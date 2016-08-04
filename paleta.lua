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
    x = px,
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
end

function Paleta:actualizar(dt)

  if love.keyboard.isDown (self.tDown) and (self.y ) <= self.maxY then
    self.y = self.y + (self.velocidad * dt)
  end

  if love.keyboard.isDown (self.tUp) and self.y >= self.minY then
    self.y = self.y - (self.velocidad * dt)
  end

end
