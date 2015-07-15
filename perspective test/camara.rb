class Camara
	attr_reader :x
	attr_reader :y
	def initialize(window, x, y, max_x, max_y)
		@window = window
		@x = x
		@y = y
		@max_x = max_x - @window.width
		@max_y = max_y - @window.height
	end
	
	def max(x, y)
		@max_x = x
		@max_y = y
	end
	
	def update(x, y)
		@x = [[x - (@window.width/2), 0].max, @max_x].min
		@y = [[y - (@window.height/2), 0].max, @max_y].min
	end
end
