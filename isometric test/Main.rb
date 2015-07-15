 $: << "."
 begin
require 'rubygems'
require 'gosu'
rescue LoadError
require 'lib/gosu'
end
include Gosu
require 'ZOrder.rb'
require 'Window.rb'
require 'FPSCounter.rb'
require 'Map.rb'
require 'Tilemap.rb'
require 'Tile.rb'
require 'Hero.rb'

#puts "fullscreen? y/n"
#case gets.chomp
#	when /(y|Y)/
#		fullscreen = true
#	when /(n|N)/
#		fullscreen = false
#end
window = Game_Window.new
window.show