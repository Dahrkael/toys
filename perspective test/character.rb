class Character
	attr_accessor :x
	attr_accessor :y
	def initialize(window, x, y, filename, twidth, theight)
		@window = window
		@x = x
		@y = y
		@check_x = @x + (twidth / 2)
		@check_y = @y + theight
		@face = :down
		@tiles = Gosu::Image.load_tiles(@window, filename, twidth, theight, false) 
		@atile = 3
	end
	
	def update
		if @window.button_down?(Gosu::KbUp)
			@face = :up
			return if @window.tilemap.solid?(@check_x, @check_y - (@window.tilemap.csize / 25).to_i)
			@y -= (@window.tilemap.csize / 25).to_i
			
		elsif @window.button_down?(Gosu::KbDown)
			@face = :down
			return if @window.tilemap.solid?(@check_x, @check_y + (@window.tilemap.csize / 25).to_i)
			@y += (@window.tilemap.csize / 25).to_i
			
		elsif @window.button_down?(Gosu::KbLeft)
			@face = :left
			return if @window.tilemap.solid?(@check_x - (@window.tilemap.csize / 25).to_i, @check_y)
			@x -= (@window.tilemap.csize / 25).to_i
			
		elsif @window.button_down?(Gosu::KbRight)
			@face = :right
			return if @window.tilemap.solid?(@check_x + (@window.tilemap.csize / 25).to_i, @check_y)
			@x += (@window.tilemap.csize / 25).to_i
			
		else
			case @face
				when :left
					@atile = 4
				when :right
					@atile = 2
				when :up
					@atile = 0
				when :down
					@atile = 3
			end
		end
	end
	
	def draw(cam_x, cam_y)
		# + 6
		if @face== :left and @window.button_down?(Gosu::KbLeft)
			if Gosu::milliseconds / 175 % 4 == 0
				@atile = 16
			elsif Gosu::milliseconds / 175 % 4 == 1
				@atile = 40
			elsif Gosu::milliseconds / 175 % 4 == 2
				@atile = 28
			elsif Gosu::milliseconds / 175 % 4 == 3
				@atile = 52
			end
		elsif @face == :right and @window.button_down?(Gosu::KbRight)
				if Gosu::milliseconds / 175 % 4 == 0
					@atile = 14
				elsif Gosu::milliseconds / 175 % 4 == 1
					@atile = 38
				elsif Gosu::milliseconds / 175 % 4 == 2
					@atile = 26
				elsif Gosu::milliseconds / 175 % 4 == 3
					@atile = 50
				end
		elsif @face == :up and @window.button_down?(Gosu::KbUp)
				if Gosu::milliseconds / 175 % 4 == 0
					@atile = 12
				elsif Gosu::milliseconds / 175 % 4 == 1
					@atile = 36
				elsif Gosu::milliseconds / 175 % 4 == 2
					@atile = 24
				elsif Gosu::milliseconds / 175 % 4 == 3
					@atile = 48
				end
		elsif @face == :down and @window.button_down?(Gosu::KbDown)
				if Gosu::milliseconds / 175 % 4 == 0
					@atile = 15
				elsif Gosu::milliseconds / 175 % 4 == 1
					@atile = 39
				elsif Gosu::milliseconds / 175 % 4 == 2
					@atile = 27
				elsif Gosu::milliseconds / 175 % 4 == 3
					@atile = 51
				end
			end
		@tiles[@atile].draw(	@x - (@tiles[@atile].width / 2) - cam_x,
						@y - (@tiles[@atile].height / 2) - cam_y,
						0, (@window.tilemap.csize / 128.0), (@window.tilemap.csize / 128.0)) 
		
		#@tiles[@atile].draw(@x - (@tiles[@atile].width / 2) - cam_x, @y - (@tiles[@atile].height / 2) - cam_y, 0)
		#@tiles[@atile+6].draw(@x - (@tiles[@atile].width / 2) - cam_x, @y - (@tiles[@atile].height / 2) + 60 - cam_y, 0)
	end
end