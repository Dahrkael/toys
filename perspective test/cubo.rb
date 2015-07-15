class Cubo
	attr_reader :x
	attr_reader :y
	attr_reader :rect
	def initialize(window, t1, size, x=0, y=0, z=0)
		@window = window
		@t1 = t1
		@size = size
		@hsize = @size / 2
		@x = x
		@y = y
		@z = z
		@center_x = @x + @hsize
		@center_y = @y + @size
		@rect = [nil, nil, nil, nil]
	end
	
	def off_screen?(cam_x, cam_y)
		#return true if Gosu::distance(@window.pj.x, @window.pj.y,@center_x, @center_y) > @size*2
		return true if @x < cam_x - @size - @hsize
		return true if @y < cam_y - @size - @hsize
		return true if @x > cam_x + @window.width + @size
		return true if@y > cam_y + @window.height
		return false
	end
	
	def inside?(x, y)
		puts "x:#{x},y:#{y} vs x:#{@center_x},y:#{@center_y}"
		return true if Gosu::distance(x, y, @center_x, @center_y) < @hsize
		return false
	end
	
	def draw(cam_x, cam_y)
		return if off_screen?(cam_x, cam_y)
		angulo = Gosu::angle(@x + @hsize, @y + @hsize, cam_x + (@window.width/2), @y - @window.height) 
		#cosa = Gosu::offset_y(angulo, 128) / 2 
		cosa2 = Gosu::offset_x(angulo, @size) / 2
		x = @x - cam_x
		y = @y - cam_y

		x += @size

		@t1.draw_as_quad(     x, 		y, 				0xFFFFFFFF, 
						x + cosa2, 	y + @hsize, 		0xFFFFFFFF, #this
						x, 		y + @size, 			0xFFFFFFFF, 
						x + cosa2, 	y + @size + @hsize, 	0xFFFFFFFF, # this
				@z) 
		@rect[1] = [x+cam_x+cosa2, y+cam_y+@hsize]
		@rect[3] = [@rect[1][0], @rect[1][1]+@size]
		x -= @size
		@t1.draw_as_quad(     x, 		y, 				0xFFFFFFFF, 
						x + cosa2, 	y + @hsize, 		0xFFFFFFFF, # this
						x, 		y + @size, 			0xFFFFFFFF, 
						x + cosa2, 	y + @size + @hsize, 	0xFFFFFFFF,  #this
				@z) 	
		@rect[0] = [x+cam_x+cosa2, y+cam_y+@hsize]
		@rect[2] = [@rect[0][0], @rect[0][1]+@size]
		@t1.draw_as_quad(     x, 		y, 			0xFFFFFFFF, 
						x + @size, 	y, 			0xFFFFFFFF, 
						x, 		y + @size, 		0xFFFFFFFF, 
						x + @size, 	y + @size, 		0xFFFFFFFF, 
				@z+1) 
		y += @size
		@t1.draw_as_quad(     x, 		y, 				 0xFFFFFFFF, 
						x + @size, 	y, 				 0xFFFFFFFF, 
						x + cosa2, 	y + @hsize, 		 0xFFFFFFFF, 
						x + @size + cosa2, 	y + @hsize, 0xFFFFFFFF, 
				@z+1) 
				
		@center_x = @rect[0][0] + @hsize
		@center_y = @rect[0][1] + @hsize
	end
	
end
