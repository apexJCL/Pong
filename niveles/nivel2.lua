require ('nivelBase')
local screen = require 'lib/shack'
screen:setDimensions(love.graphics.getDimensions())

Nivel2 = Nivel:nuevo()

function Nivel2:inicializar ()
  local imagen_paleta = love.graphics.newImage('assets/paleta_modern.png')
  local w, h = 32, 128 -- Tamaños internos del sprite
  local ow, oh = imagen_paleta:getDimensions()
  -- margen de las paletas
  local margen = 10

  -- Creamos las paletas
  paleta_a = Paleta:nuevo(imagen_paleta, 0, 'w', 's', h/2, love.graphics.getHeight() - (h / 2))
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

  paleta_b = Paleta:nuevo(imagen_paleta, 0, 'up', 'down', h/2, love.graphics.getHeight() - (h / 2))
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
    screen.setDimensions(w, h)
  end

  -- Pelota
  local imagen_pelota = love.graphics.newImage('assets/particula_blanca.png')
  pelota = Pelota:nuevo(imagen_pelota)

  -- Partìcula
  local particula_pelota = Particula:nuevo(love.graphics.newImage('assets/particula_blanca.png'), 300)
  particula_pelota:inicializar(0, -pelota.alto * 2, 0, pelota.alto * 2)

  particula_choque = Particula:nuevo(love.graphics.newImage('assets/particula_blanca.png'), 200)
  particula_choque:inicializar(0, -1000, 100, 1000)
  particula_choque.c = {
    r = 250,
    g = 250,
    b =10,
    a = 255
  }
  -- Configuración extra de la particula de choque
  particula_choque.sistema:setSizes(0.1, 0.2, 0.4, 0.6, 0.8)
  particula_choque.sistema:setSizeVariation(1)

  -- Sobreescribimos la funcion de la particula_pelota
  function particula_pelota:actualizar (dt)
    self.sistema:setPosition(pelota.x, pelota.y)
    self.sistema:update(dt)
    self:emitir(1)
  end

  function particula_choque:actualizar (dt)
    self.sistema:update(dt)
  end

  paletas = {
    paleta_a,
    paleta_b
  }
  -- Fuente
  self.f = love.graphics.newFont('assets/fonts/ps2p.ttf', 96)

  -- Ultima configuración
  pelota.velocidad_x, pelota.velocidad_y = 400, 300
  paleta_a.velocidad = 400
  paleta_b.velocidad = 400

  -- Agregamos
  self:agregarActor(paleta_a)
  self:agregarActor(paleta_b)
  self:agregarActor(pelota)
  self:agregarActor(particula_pelota)
  self:agregarActor(particula_choque)
  return self
end

function Nivel2:actualizar (dt)

  -- Actualizar
  screen:update(dt)

  if pelota:pegando(paletas) then
    screen:setRotation(pelota.direccion_x * 0.3)
    screen:setShake(20)
    pelota:aumentarVelocidad(dt, 500)
    particula_choque.sistema:setPosition(pelota.x, pelota.y)
    particula_choque:emitir(200)
  end

  -- Para ver si hay que aumentar la puntuación
  local d = pelota:reiniciar()
  if d < 0 then
    paleta_a.puntos = paleta_a.puntos + 1
  elseif d > 0 then
    paleta_b.puntos = paleta_b.puntos + 1
  end

  for k,actor in pairs(self.actores) do
    actor:actualizar(dt)
  end
end


function Nivel2:dibujar ()
  screen:apply()
  -- Puntuacion
  love.graphics.setFont(self.f)
  love.graphics.printf(
    paleta_a.puntos..' - '..paleta_b.puntos,
    0,
    40,
    love.graphics.getWidth(),
    'center')
  for k,actor in pairs(self.actores) do
    actor:dibujar()
  end
end
