require ('nivelBase')

Nivel2 = Nivel:nuevo()

function Nivel2:inicializar ()
  local imagen_paleta = love.graphics.newImage('assets/paleta_modern.png')
  local w, h = 32, 128 -- Tamaños internos del sprite
  local ow, oh = imagen_paleta:getDimensions()
  -- margen de las paletas
  local margen = 10

  -- Creamos las paletas
  local paleta_a = Paleta:nuevo(imagen_paleta, 0, 'w', 's', h/2, love.graphics.getHeight() - (h / 2))
  -- Sobre-escribimos los valores con los reales internos de la imagen
  paleta_a.x = w / 2 + margen
  paleta_a.ancho, paleta_a.alto = w, h
  paleta_a.o_ancho, paleta_a.o_alto = ow, oh
  -- Color
  paleta_a:setColor({
    r = 255,
    g = 0,
    b = 255,
    a = 255
  })

  local paleta_b = Paleta:nuevo(imagen_paleta, 0, 'up', 'down', h/2, love.graphics.getHeight() - (h / 2))
  -- Sobre-escribimos los valores con los reales internos de la imagen
  paleta_b.x = love.graphics.getWidth() - w/2 - margen
  paleta_b.ancho, paleta_b.alto = w, h
  paleta_b.o_ancho, paleta_b.o_alto = ow, oh
  -- Color
  paleta_b:setColor({
    r = 0,
    g = 255,
    b = 255,
    a = 255
  })

  -- Sobreescribimos la funcion de dibujado de las Paletas
  function Paleta:dibujar ()
    -- Cambia el color
    love.graphics.setColor(self.c.r, self.c.g, self.c.b, self.c.a)
    love.graphics.draw(self.drawable, self.x, self.y, 0, 1, 1, self.o_ancho / 2, self.o_alto / 2)
    -- Restauramos el color de dibujado
    love.graphics.setColor(255, 255, 255, 255)
    self:debug()
  end

  -- Definimos nuestra función de redimensionado
  function love.resize(w, h)
    local maxY = h - paleta_a.alto / 2
    paleta_a.x, paleta_a.maxY = margen + paleta_a.ancho / 2, maxY
    paleta_b.x, paleta_b.maxY = w - paleta_b.ancho / 2 - margen, maxY
  end

  -- Pelota
  local imagen_pelota = love.graphics.newImage('assets/particula_blanca.png')
  local pelota = Pelota:nuevo(imagen_pelota)

  -- Partìcula
  local particula = Particula:nuevo(love.graphics.newImage('assets/particula_blanca.png'), 300)
  particula:inicializar(-10, -pelota.alto * 2, 10, pelota.alto * 2)

  -- Sobreescribimos la funcion de la particula
  function particula:actualizar (dt)
    self.sistema:setPosition(pelota.x, pelota.y)
    self.sistema:update(dt)
    self:emitir(1)
  end

  -- Agregamos
  self:agregarActor(paleta_a)
  self:agregarActor(paleta_b)
  self:agregarActor(pelota)
  self:agregarActor(particula)
  return self
end
