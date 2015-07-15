include Gosu
class Tilemap
	attr_accessor :first_layer
	attr_reader :hero_coords
	def initialize(window, map)
		@window = window
		@map = map
		@mapp = File.open(@map, 'r').map { |line| line.chomp }
		@height = @mapp.size
		@width = @mapp[0].size
		@first_layer = parse
	end

	def parse
		tiles = Array.new(@height) do |y|
			Array.new(@width) do |x|
			
				case @mapp[y][x, 1]
					when '1'
						Tile.new(@window, "green", "pared", "pared", x, y,0)
					when '2'
						@hero_coords = [x,y]
						Tile.new(@window, "green","pared", "pared", x, y,0)
					when '0'
						nil
				end
			end
		end
		return tiles
	end

	def update
		@height.times do |y|
			@width.times do |x|
					tile = @first_layer[y][x]
				if tile 
					@first_layer[y][x].update
				end
			end
		end
	end
	
	def draw
		@height.times do |y|
			@width.times do |x|
					tile = @first_layer[y][x]
				if tile 
					@first_layer[y][x].draw
				end
			end
		end
	end

end
