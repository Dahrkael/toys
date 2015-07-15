include Gosu
class Hero
	attr_accessor :x
	attr_accessor :tile_x
	attr_accessor :y
	attr_accessor :tile_y
	attr_accessor :z
	attr_accessor :direccion
	attr_reader :pose
	
	def initialize(window, tile_x, tile_y)
		@window = window
		@tile_x = tile_x
		@tile_y = tile_y
		@z = ZOrder::Hero
		@poses = Image.load_tiles(@window, "images/chara.png", 60, 68, false)
		@pose = @poses[0]
		@direccion = :down
		@tile_x = tile_x
		@tile_y  = tile_y
		@width = 100.0
		@height = 100.0
		@camera_y = @window.camera_y
		@camera_x = @window.camera_x
		@r = @window.r
		@x = (@tile_x - @tile_y) * (@width / 2) + @camera_x
		@y = (@tile_x + @tile_y) * (@height / 2 ) * @r + @camera_y
	end
	
	def walk
		if @window.scene.solid?(@direccion)
		case @direccion
			when :up
				@tile_x -= 0.125 # diagonal
				#@tile_x -= 0.125 # cruceta
				#@tile_y -= 0.125 # cruceta
			when :down
				@tile_x += 0.125 # diagonal
				#@tile_x += 0.125 # cruceta
				#@tile_y += 0.125 # cruceta
			when :left
				@tile_y += 0.125 # diagonal
				#@tile_x -= 0.125 # cruceta
				#@tile_y += 0.125 # cruceta
			when :right
				@tile_y -= 0.125 # diagonal
				#@tile_x += 0.125 # cruceta
				#@tile_y -= 0.125 # cruceta
			end
			@x = (@tile_x - @tile_y) * (@width / 2) + @camera_x
			@y = (@tile_x + @tile_y) * (@height / 2 ) * @r + @camera_y
		end
		return [@x, @y]
	end
  
	def update
		#@x_pies = @x + (@pose.width/2)
		#@y_pies = @y + @pose.height
		if @window.button_down?(Button::KbLeft) #and @x > 0 - @window.scene.screen_x
			@direccion = :left
			walk
		elsif @window.button_down?(Button::KbRight) #and @x < (@window.scene.width * 32) - @pose.width
			@direccion = :right
			walk
		elsif @window.button_down?(Button::KbUp) #and @y > 0 - @window.scene.screen_y
			@direccion = :up
			walk
		elsif @window.button_down?(Button::KbDown) #and @y < (@window.scene.height * 32) - @pose.height
			@direccion = :down
			walk
		else 
			case @direccion
				when :left
					@pose = @poses[4]
				when :right
					@pose = @poses[9]
				when :up
					@pose = @poses[12]
				when :down
					@pose = @poses[0]
			end
		end
	end
	
	def draw
		if @direccion == :left and @window.button_down?(Button::KbLeft)
			if milliseconds / 175 % 4 == 0
				@pose = @poses[4]
			elsif milliseconds / 175 % 4 == 1
				@pose = @poses[5]
			elsif milliseconds / 175 % 4 == 2
				@pose = @poses[6]
			elsif milliseconds / 175 % 4 == 3
				@pose = @poses[7]
			end
		elsif @direccion == :right and @window.button_down?(Button::KbRight)
				if milliseconds / 175 % 4 == 0
					@pose = @poses[8]
				elsif milliseconds / 175 % 4 == 1
					@pose = @poses[9]
				elsif milliseconds / 175 % 4 == 2
					@pose = @poses[10]
				elsif milliseconds / 175 % 4 == 3
					@pose = @poses[11]
				end
		elsif @direccion == :up and @window.button_down?(Button::KbUp)
			if milliseconds / 175 % 4 == 0
					@pose = @poses[12]
				elsif milliseconds / 175 % 4 == 1
					@pose = @poses[13]
				elsif milliseconds / 175 % 4 == 2
					@pose = @poses[14]
				elsif milliseconds / 175 % 4 == 3
					@pose = @poses[15]
				end
		elsif @direccion == :down and @window.button_down?(Button::KbDown)
			if milliseconds / 175 % 4 == 0
					@pose = @poses[0]
				elsif milliseconds / 175 % 4 == 1
					@pose = @poses[1]
				elsif milliseconds / 175 % 4 == 2
					@pose = @poses[2]
				elsif milliseconds / 175 % 4 == 3
					@pose = @poses[3]
				end
			end
		@pose.draw(@x + (@pose.width/3) - @window.camera_x,@y - (@pose.height/2) - @window.camera_y, ZOrder::Hero+@z)
	end
	
end