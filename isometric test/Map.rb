include Gosu

class Map
	attr_reader :tiles
	attr_accessor :hero
	def initialize(window)
		@window = window
		@camera_x = 0
		@camera_y = 0
		@fondo = Image.new(@window, "images/mazes.png", false)
		@tilemap = Tilemap.new(@window, "map.txt")
		@hero = Hero.new(@window, @tilemap.hero_coords[0], @tilemap.hero_coords[1])
	end
	
	def solid?(direccion)
		begin
		case direccion
			when :left
				return true if @tilemap.first_layer[@hero.tile_y+1][@hero.tile_x]
			when :right
				return true if @tilemap.first_layer[@hero.tile_y-0.25][@hero.tile_x]
			when :up
				return true if @tilemap.first_layer[@hero.tile_y][@hero.tile_x-0.25]
			when :down
				return true if @tilemap.first_layer[@hero.tile_y][@hero.tile_x+1]
		end
		rescue
			return false
		end
	end
	
	def update
		@window.camera_x = @hero.x + (@hero.pose.width/2) - 320
		@window.camera_y = @hero.y + (@hero.pose.width/2) - 240
		
		@tilemap.update
		@hero.update
	end
	
	def draw
		@tilemap.draw
		@hero.draw
		#@fondo.draw(0,0 , 0)
	end
	
	def button_down(id)
		
	end
end