include Gosu
class Tile	
	attr_reader :tile_x
	attr_reader :tile_y
	attr_accessor :z
	def initialize(window, texture1, texture2, texture3, tile_x, tile_y, z)
		@window = window
		@texture1 = Image.new(@window, "images/textures/"+texture1+".png", true)
		@texture2 = Image.new(@window, "images/textures/"+texture2+".png", true)
		@texture3 = Image.new(@window, "images/textures/"+texture3+".png", true)
		@color_claro = @window.color_claro
		@color_oscuro = @window.color_oscuro
		@color_translucido = @window.color_translucido
		@z = z
		
		@esquina1 = @color_claro
		@esquina2 = @color_claro
		@esquina3 = @color_claro
		@esquina4 = @color_claro
		
		@tile_x = tile_x
		@tile_y  = tile_y
		
		@width = 100.0
		@height = 100.0
		
		@camera_y = @window.camera_y
		@camera_x = @window.camera_x
		
		@r = @window.r
		
		@x = (@tile_x - @tile_y) * (@width / 2) - @camera_x
		@y = (@tile_x + @tile_y) * (@height / 2 ) * @r - @camera_y
		
	end
	
	def x1
		return @x + @width/2 #- @window.camera_x
	end

	def x2
		return @x + @width #- @window.camera_x
	end
	
	def x3
		return @x #- @window.camera_x
	end
	
	def x4
		return @x +@width/2 #- @window.camera_x
	end

	def y1
		return @y #- @window.camera_y
	end

	def y2
		return @y+@height * (@r/2) #- @window.camera_y
	end
	
	def y3
		return @y+@height * (@r/2) #- @window.camera_y
	end
	
	def y4
		return @y+@width * @r #- @window.camera_y
	end

	def tile_x # Coordenadas logicas, en una cuadricula
		return @tile_x
	end
	
	def tile_y # Coordenadas logicas, en una cuadricula
		return @tile_y
	end
	
	def width # Dimensiones de la casilla en la cuadricula
		return @width 
	end

	def height # Dimensiones de la casilla en la cuadricula
		return @height 
	end
	
	def update
		@camera_x = @window.camera_x
		@camera_y = @window.camera_y
		@y = (@tile_x + @tile_y) * (@height / 2) * @r - @camera_y 
		@x = (@tile_x - @tile_y) * (@width / 2) - @camera_x 
		
	end
	
	def draw
		# Suelo
		@texture1.draw_as_quad(self.x1, self.y1, @esquina1, self.x2, self.y2, @esquina2, self.x3, self.y3, @esquina3, self.x4, self.y4, @esquina4, ZOrder::Map+@z, :default) 
		@window.pasable.draw_as_quad(self.x1, self.y1, @color_translucido, self.x2, self.y2, @color_translucido, self.x3, self.y3, @color_translucido, self.x4, self.y4, @color_translucido, ZOrder::Map+@z, :default) if @window.grid == true
		# Pared derecha
		@texture3.draw_as_quad(self.x2, self.y2, @color_claro, self.x4, self.y4, @color_claro, self.x4, self.y4+(@height/2.5)+3, @color_oscuro, self.x2, self.y2+(@height/2.5)+3, @color_oscuro, ZOrder::Map+@z, :default)
		# Pared izquierda
		@texture2.draw_as_quad(self.x3, self.y3, @color_claro, self.x4, self.y4, @color_claro, self.x4, self.y4+(@height/2.5)+3, @color_oscuro, self.x3, self.y3+(@height/2.5)+3, @color_oscuro, ZOrder::Map+@z, :default)
	end
	
end
