-- Cargamos el archivo de nivel Base
require('nivelBase')
-- Creamos el nivel
Nivel0 = Nivel:nuevo()

function Nivel:inicializar ()
  -- Cargar la imagen de la paleta
  local imagen_paleta_a = love.graphics.newImage('assets/paleta_a.png')
  local w, h = imagen_paleta_a:getDimensions()
  -- Color paleta 1
  local color = {
    r = 16,
    g = 16,
    b = 214,
    a = 128
  }
  -- Crear la paleta
  local paleta_a = Paleta:nuevo(imagen_paleta_a, 0, 'w', 's')
  paleta_a:setColor(color)

  local paleta_b = Paleta:nuevo(imagen_paleta_a, love.graphics.getWidth() - w, 'up', 'down')
  -- Agregar actor
  self:agregarActor(paleta_a)
  self:agregarActor(paleta_b)
  return self
end
