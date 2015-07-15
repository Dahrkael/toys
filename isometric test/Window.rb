include Gosu

class Game_Window < Gosu::Window
	attr_reader :r
	attr_accessor :camera_x
	attr_accessor :camera_y
	attr_reader :color_claro
	attr_reader :color_oscuro
	attr_reader :color_translucido
	attr_reader :pasable
	attr_reader :grid
	attr_accessor :scene
	
	def initialize
		width = 640
		height = 480
		#fullscreen = Fullscreen::Enabled
		super(width, height, false)#fullscreen)
		self.caption = "Isometric Test"
		@color_claro = Color.new(255,255,255,255)
		@color_translucido = Color.new(100,255,255,255)
		@color_oscuro = Color.new(255,150,150,150)
		@pasable = Image.new(self, "images/textures/pasable.png", true)
		@grid = false
		@r = 3.0/7.0                        # relacion de perspectiva (i.e.  3/4)
		@camera_x = 0                # Desplazamiento global del mapa, como para mover la camara
		@camera_y = 0                # Desplazamiento global del mapa, como para mover la camara
		@fpscounter = FPSCounter.new(self)
		@scene = Map.new(self)
	end
	
	def button_down(id)
		@scene.button_down(id)
		if id == Button::KbF
			@fpscounter.show_fps = !@fpscounter.show_fps
		end
		if id == Button::KbP
			@grid = !@grid
		end
	end
	

	def update
		@fpscounter.update
		@scene.update
	end
	
	def draw
		@scene.draw
		@fpscounter.draw
	end
	
end
