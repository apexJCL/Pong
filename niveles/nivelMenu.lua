require('nivelBase')

Menu = Nivel:nuevo()

function Menu:inicializar ()
  self.bg = love.graphics.newImage('assets/fondo.png')
  self:agregarActor(bg)
  return self
end

function Menu:dibujar ()
  love.graphics.draw(self.bg, 0, 0)
end
