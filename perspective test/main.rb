$: << "."
require 'rubygems'
require 'gosu'
require 'camara.rb'
require 'cubo.rb'
require 'character.rb'
require 'tilemap.rb'

class Ventana < Gosu::Window
	attr_reader :tilemap
	attr_reader :camara
	attr_reader :pj
	def initialize
		super(640, 480, false)
		self.caption = "Test Perspectiva #{Gosu::fps}"
		@tilemap = Tilemap.new(self, 128)
		@camara = Camara.new(self, 0, 0, @tilemap.width*@tilemap.csize, @tilemap.height*@tilemap.csize)
		@pj = Character.new(self, 3*@tilemap.csize, 2*@tilemap.csize, "emi_1.png", 65, 80)
	end
	
	def update
		self.caption = "Test Perspectiva [#{Gosu::fps}] - Cam: [ #{@camara.x} ] [ #{@camara.y} ]"
		@pj.update
		@camara.update(@pj.x, @pj.y)
	end
	
	def draw
		@tilemap.draw(@camara.x, @camara.y)
		@pj.draw(@camara.x, @camara.y)
	end
	
	def button_down(id)
		case id
			when Gosu::KbEscape
			 exit
		 end
	end
end

ventana = Ventana.new
ventana.show