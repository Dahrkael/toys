class Tilemap
	attr_reader :csize
	attr_reader :width
	attr_reader :height
	def initialize(window, csize)
		@window = window
		@csize = csize
		@tex = []
		for i in 1..11
			@tex << Gosu::Image.new(@window, "#{i}.png", true)
		end
		
		@mapa =  [[1,1,1,1,1,1,1,1,1,1],
				[1,0,0,0,0,0,0,0,0,1],
				[1,0,0,0,1,0,1,1,0,1],
				[1,0,0,0,1,0,0,1,0,1],
				[1,0,1,0,1,1,0,1,0,1],
				[1,0,1,0,1,1,0,0,0,1],
				[1,0,0,0,0,0,0,1,0,1],
				[1,0,1,0,1,1,0,1,0,1],
				[1,0,0,0,0,0,0,0,0,1],
				[1,1,1,1,1,1,1,1,1,1]]
				
		@cubos = Marshal.load( Marshal.dump( @mapa ) )
		
		z = 0
		for y in 0..9
			for x in 0..9
				if @mapa[y][x] == 1
					@cubos[y][x] = Cubo.new(@window, @tex[9], @csize, x*@csize, y*@csize, z)
				else
					@cubos[y][x] = nil
				end
			end
			z += 1
		end
		
		@width = @mapa[0].size
		@height = @mapa.size
	end
	
	def update
	end
	
	def solid?(x, y)
		@cubos.each do |row|
			row.each do |cubo|
				if cubo
					if !cubo.off_screen?(@window.camara.x, @window.camara.y)
						return true if cubo.inside?(x, y)
					end
				end
			end
		end
		return false
	end
	
	def draw(cam_x, cam_y)
		@cubos.each do |row|
			row.each do |cubo|
				if cubo
					cubo.draw(cam_x, cam_y) 
				end
			end
		end
	end
end
