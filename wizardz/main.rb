require 'gosu'
 
 def log(text)
	#puts text
end

class Background
	def initialize(x, y, width, height, tile_size, color1, color2, z)
		@x = x
		@y = y
		@width = width
		@height = height
		@tile_size = tile_size
		@color1 = color1
		@color2 = color2
		@z = z
	end
	
	def draw
		Gosu::draw_quad(@x, @y, @color1, @width, @y, @color1, @x, @height, @color1, @width, @height, @color1, @z)
		
		tiles_x = @width / @tile_size
		tiles_y = @height / @tile_size
		
		for x in 0..tiles_x - 1
			for y in 0..tiles_y - 1
				next if x % 2 != y % 2
				pos_x = @x + x * @tile_size
				pos_y = @y + y * @tile_size
				Gosu::draw_quad(pos_x, pos_y, @color2, pos_x + @tile_size, pos_y, @color2, pos_x, pos_y + @tile_size, @color2, pos_x + @tile_size, pos_y + @tile_size, @color2, @z)
			end
		end
	end
end

class AttackEffect
	attr_reader :step
	
	def initialize(origin, destiny, team)
		@team = team
		@origin = origin.dup
		@destiny = destiny.dup
		
		@step = :move
		@color1 = Gosu::Color::BLUE if @team == :blue
		@color2 = Gosu::Color::CYAN if @team == :blue
		@color1 = Gosu::Color::RED if @team == :red
		@color2 = Gosu::Color::FUCHSIA if @team == :red
		@angle = Gosu::angle(@origin[0], @origin[1], @destiny[0], @destiny[1]) 
		@distance = Gosu::distance(@origin[0], @origin[1], @destiny[0], @destiny[1]) 
		@current_point = @origin.dup
		@width = 2
	end

	def update
		if @step == :move
			x = Gosu::offset_x(@angle, @distance / 10)
			y = Gosu::offset_y(@angle, @distance / 10)
			@current_point[0] += x
			@current_point[1] += y
			@step = :expand if Gosu::distance(@current_point[0], @current_point[1], @destiny[0], @destiny[1]) < 5
		end
		if @step == :expand
			@width += 1
			return true if @width >= 10
		end
		return false
	end

	def draw(z)
		offset_x_c = Gosu::offset_x(@angle + 90, 2)
		offset_y_c = Gosu::offset_y(@angle + 90, 2)
		offset_x = Gosu::offset_x(@angle + 90, @width)
		offset_y = Gosu::offset_y(@angle + 90, @width)
		
		#expanded
		Gosu::draw_quad(@origin[0] + offset_x, @origin[1] + offset_y, @color2, 
						@origin[0] - offset_x, @origin[1] - offset_y, @color2, 
						@current_point[0] + offset_x, @current_point[1] + offset_y, @color2,
						@current_point[0] - offset_x, @current_point[1] - offset_y, @color2, 
						z, :additive) 
		#core
		Gosu::draw_quad(@origin[0] + offset_x_c, @origin[1] + offset_y_c, @color1, 
						@origin[0] - offset_x_c, @origin[1] - offset_y_c, @color1, 
						@current_point[0] + offset_x_c, @current_point[1] + offset_y_c, @color1,
						@current_point[0] - offset_x_c, @current_point[1] - offset_y_c, @color1, 
						z, :default) 
		
	end
end

class Ray
	def initialize(origin, destiny, all_energies, positions)
		@origin = origin.dup
		@destiny = destiny.dup
		@all_energies = all_energies.dup
		@all_energies.reject! { |energy| positions[energy.position] == origin }
		@positions = positions.dup
		@angle = Gosu::angle(@origin[0], @origin[1], @destiny[0], @destiny[1]) 
		@distance = Gosu::distance(@origin[0], @origin[1], @destiny[0], @destiny[1]) 
		@current_point = @origin.dup
		@width = 35
		@step = 5
	end
	
	def launch!
		x = Gosu::offset_x(@angle, @step)
		y = Gosu::offset_y(@angle, @step)
		side_x = Gosu::offset_x(@angle - 90, @width)
		side_y = Gosu::offset_y(@angle - 90, @width)
		
		while Gosu::distance(@destiny[0], @destiny[1], @current_point[0], @current_point[1]) > @step
			@current_point[0] += x
			@current_point[1] += y
			hits = @all_energies.select { |energy| 
				position = @positions[energy.position] 
				(Gosu::distance(position[0], position[1], @current_point[0], @current_point[1]) <= @step) or
				(Gosu::distance(position[0], position[1], @current_point[0] + side_x, @current_point[1] + side_y) < @width) or
				(Gosu::distance(position[0], position[1], @current_point[0] - side_x, @current_point[1] - side_y) < @width)
			}
			first_hit = hits[0] if hits
			return first_hit if first_hit
		end
		return nil
	end
	
end

class Triangle
	attr_accessor :color1
	attr_accessor :color2
	attr_accessor :color3
	attr_accessor :rotating
	attr_accessor :shifting
	
	def initialize(spacing, initial_angle, color)
	@spacing = spacing
	@rotating = false
	@shifting = false
	
	@color1 = color
	@color2 = color#Gosu::Color.from_hsv(color.hue + 90, color.saturation, color.value)
	@color3 = color#Gosu::Color.from_hsv(color.hue - 90, color.saturation, color.value)
	
	@angle = initial_angle
	end
	
	def update(degrees)
		if rotating 
			@angle += degrees
		else
			@angle = degrees
		end
		
		shift_hue if shifting
	end
	
	def draw(x, y, z, ratio)
		x1 = Gosu::offset_x(@angle, @spacing * ratio)
		y1 = Gosu::offset_y(@angle, @spacing * ratio)
		
		x2 = Gosu::offset_x(@angle + 120, @spacing * ratio)
		y2 = Gosu::offset_y(@angle + 120, @spacing * ratio)
		
		x3 = Gosu::offset_x(@angle - 120, @spacing * ratio)
		y3 = Gosu::offset_y(@angle - 120, @spacing * ratio)
		
		
		Gosu::draw_triangle(x + x1, y + y1, @color1, x + x2, y + y2, @color2, x + x3, y + y3, @color3, z)
	end
	
	def shift_hue
		@color1 = Gosu::Color.from_hsv(@color1.hue + 1, @color1.saturation, @color1.value)
		@color2 = Gosu::Color.from_hsv(@color2.hue + 1, @color2.saturation, @color2.value)
		@color3 = Gosu::Color.from_hsv(@color3.hue + 1, @color3.saturation, @color3.value)
	end
end

class EnergyVisual
	
	def self.default_spacing
		@@default_spacing ||= 35
	end
	
	def initialize(color1, color2, color3)
		@alternate = false
		
		@triangle1 = Triangle.new(EnergyVisual.default_spacing, rand(0..360), color1)
		@triangle1.rotating = true
		@triangle2 = Triangle.new(EnergyVisual.default_spacing, rand(0..360), color2)
		@triangle2.rotating = true
		@triangle3 = Triangle.new(EnergyVisual.default_spacing, rand(0..360), color3)
		@triangle3.rotating = true
	end

	def update
		@triangle1.update(3)
		@triangle2.update(-6)
		@triangle3.update(9)
	end
	
	def draw(x, y, z, ratio)
		@triangle1.draw(x, y, z, ratio)
		@triangle2.draw(x, y, z, ratio)
		@triangle3.draw(x, y, z, ratio)
		
		#@alternate = !@alternate
	end
end

class Text
	attr_accessor :color
	def initialize(fontsize = 18, color=0xff000000)
		@font = Gosu::Font.new(fontsize)
		@color = color
		@text = ""
	end
	
	def update(text)
		@text = text
	end
	
	def draw(x, y, z, centered=true)
		#@@font.draw_rel(@points.to_s, x + 1, y + 1, z, 0.5, 0.5, 1, 1, 0xffFFFFFF, :default)
		#@@font.draw_rel(@points.to_s, x - 1, y - 1, z, 0.5, 0.5, 1, 1, 0xffFFFFFF, :default)
		#@@font.draw_rel(@points.to_s, x + 1, y - 1, z, 0.5, 0.5, 1, 1, 0xffFFFFFF, :default)
		#@@font.draw_rel(@points.to_s, x - 1, y + 1, z, 0.5, 0.5, 1, 1, 0xffFFFFFF, :default)
		
		origin = 0.5 if centered
		origin = 0.0 if !centered
		@font.draw_rel(@text, x, y, z, origin, origin, 1, 1, @color, :default)
	end
end

class EnergyText < Text
	def initialize(fontsize = 18, color=0xff000000)
		super(fontsize, color)
		@points = 0
	end
	
	def update(points)
		@points = points
		@text = @points.to_s
	end
end

class Energy

	attr_reader :team
	attr_accessor :points
	attr_accessor :position
	attr_accessor :ratio
	
	attr_reader :wizards_allies
	attr_reader :wizards_enemies
	
	def initialize(team, position)
		@@energy_step ||= 1000
		
		@position = position
		@team = team
		
		@points = 0
		@wizards_allies = []
		@wizards_enemies = []
		@timestamp = Gosu::milliseconds
		
		if team == :blue
			@venergy = EnergyVisual.new(Gosu::Color::CYAN, Gosu::Color::BLUE, Gosu::Color::CYAN)
		end
		if team == :red
			@venergy = EnergyVisual.new(Gosu::Color.argb(0xFFFF6600), Gosu::Color::RED, Gosu::Color.argb(0xFFFF6600))
		end
		if team == :neutral
			@venergy = EnergyVisual.new(Gosu::Color::YELLOW, Gosu::Color::GREEN, Gosu::Color::YELLOW)
		end
		
		@text = EnergyText.new
		@ratio = 1
	end
	
	def add_wizard(wizard, friendly)
		@wizards_allies << wizard if friendly
		@wizards_enemies << wizard if !friendly
	end
	
	def remove_wizard(wizard, friendly)
		@wizards_allies.delete(wizard) if friendly
		@wizards_enemies.delete(wizard) if !friendly
	end
	
	def has_free_slots?
		current_slots = @wizards_allies.length + @wizards_enemies.length
		total = 340 / 20
		return false if current_slots >= total
		return true
	end
	
	def get_free_slot
		current_wizards = @wizards_allies + @wizards_enemies
		free_angles = 0.step(340, 21).to_a
		used_angles = current_wizards.collect { |wizard| wizard.angle }
		free_angles -= used_angles
		if free_angles.length > 0
			return free_angles[rand(free_angles.length)]
		else
			log "no free angles available"
			return false
		end
	end
	
	def get_random_wizard(team)
		return @wizards_allies[rand(@wizards_allies.length)] if team == @team
		return @wizards_enemies[rand(@wizards_enemies.length)] if team != @team
	end
	
	def update
		@venergy.update
		@wizards_allies.each { |wizard| wizard.update }
		@wizards_enemies.each { |wizard| wizard.update }
		
		if Gosu::milliseconds > (@timestamp + @@energy_step)
			@points += @wizards_allies.length
			@points -=  @wizards_enemies.length
			@timestamp = Gosu::milliseconds
		end
		
		@text.update(@points)
	end
	
	def draw(x, y)
		@venergy.draw(x, y, 1, @ratio)
		@text.draw(x, y, 2)
		@wizards_allies.each { |wizard| wizard.draw(x, y, 1) }
		@wizards_enemies.each { |wizard| wizard.draw(x, y, 1) }
	end
	
	def to_s
		return "Energy [position: #{@position} team: #{@team}]"
	end
end


class Wizard
	attr_accessor :angle
	attr_reader :team
	
	def initialize(team)
		@@width ||= 25
		@@height ||= 25
		
		@team = team
		if team == :blue
			@color1 = Gosu::Color.argb(0xff0f438c)
			@color2 = Gosu::Color.argb(0xff125ec9)
		end
		if team == :red
			@color1 = Gosu::Color.argb(0xff9b0a0a)
			@color2 = Gosu::Color.argb(0xffd60c0c)
		end
		@face = Triangle.new(@@width / 2, 0, @color2)
		@face.color1 = Gosu::Color::WHITE
		@angle = 0
	end
	
	def update
		@face.update(@angle + 180);
	end
	
	def draw(x, y, z)
		pos_x = (x - @@width / 2) + Gosu::offset_x(@angle, EnergyVisual.default_spacing)
		pos_y = (y - @@height / 2) + Gosu::offset_y(@angle, EnergyVisual.default_spacing)
		
		#Gosu::draw_quad(pos_x, pos_y, @color1, pos_x + @@width, pos_y, @color1, pos_x, pos_y + @@height, @color1, pos_x + @@width, pos_y + @@height, @color1, z)
		@face.draw(pos_x + (@@width / 2), pos_y + (@@height / 2), z, 1)
	end
end

class Cursor
	attr_accessor :position
	attr_accessor :team
	
	def initialize(position, team)
		@@width ||= 75
		@@height ||= 75
		
		@position = position
		@team = team
		@color = Gosu::Color::BLUE if team == :blue
		@color = Gosu::Color::RED if team == :red
	end
	
	def update
		@color = Gosu::Color.argb((@color.alpha + 5) % 0xFF, @color.red, @color.green, @color.blue)
	end
	
	def draw(x, y, z)
		Gosu::draw_quad(x - (@@width / 2), y - (@@height / 2), @color, 
						x + (@@width / 2), y - (@@height / 2), @color, 
						x - (@@width / 2), y + (@@height / 2), @color, 
						x + (@@width / 2), y + (@@height / 2), @color, 
						z, :additive)
	end
end

class UI
	def initialize(z)
		@z = z
		@winner = nil
		
		@winner_title = Text.new(42, 0xffFFFFFF)
		@winner_subtitle = Text.new(20, 0xffFFFFFF)
		
		@red_title = Text.new(24, 0xffFF0000)
		@blue_title = Text.new(24, 0xff0000FF)
		
		@red_energy_title = Text.new(24, 0xffFFFFFF)
		@blue_energy_title = Text.new(24, 0xffFFFFFF)
		@red_energy_value = EnergyText.new(24, 0xffFFFFFF)
		@blue_energy_value = EnergyText.new(24, 0xffFFFFFF)
		
		@red_next_energy_title = Text.new(24, 0xffFFFFFF)
		@blue_next_energy_title = Text.new(24, 0xffFFFFFF)
		@red_next_energy_value = EnergyText.new(24, 0xffFFFFFF)
		@blue_next_energy_value = EnergyText.new(24, 0xffFFFFFF)
		
		@red_next_wizard_title = Text.new(24, 0xffFFFFFF)
		@blue_next_wizard_title = Text.new(24, 0xffFFFFFF)
		@red_next_wizard_value = EnergyText.new(24, 0xffFFFFFF)
		@blue_next_wizard_value = EnergyText.new(24, 0xffFFFFFF)
		
		@red_title.update("RED")
		@blue_title.update("BLUE")
		
		@red_energy_title.update("Current ENERGY")
		@blue_energy_title.update("Current ENERGY")
		
		@red_next_energy_title.update("Next Energy ball cost")
		@blue_next_energy_title.update("Next Energy ball cost")
		
		@red_next_wizard_title.update("Next Wizard cost")
		@blue_next_wizard_title.update("Next Wizard cost")
	end
	
	def reset!
		@winner = nil
	end
	
	def set_winner(winner)
		@winner = winner
		@winner_title.color = winner == :blue ? Gosu::Color::BLUE : Gosu::Color::RED
		@winner_title.update(winner.to_s.upcase + " WINS")
		@winner_subtitle.update("Press RETURN to play again!")
	end
	
	def update(energy_manager)
		@red_energy_value.update(energy_manager.current_points(:red))
		@blue_energy_value.update(energy_manager.current_points(:blue))
		
		@red_next_energy_value.update(energy_manager.next_energy_cost(:red))
		@blue_next_energy_value.update(energy_manager.next_energy_cost(:blue))
		
		@red_next_wizard_value.update(energy_manager.next_wizard_cost(:red))
		@blue_next_wizard_value.update(energy_manager.next_wizard_cost(:blue))
	end
	
	def draw
		if !@winner
			x = 50
			y = $screen_height + 10
			value_margin = + $screen_width / 3
			@red_title.draw(x, y, @z, false)
			y += 30
			@red_energy_title.draw(x, y, @z, false)
			@red_energy_value.draw(x + value_margin, y, @z, false)
			y += 30
			@red_next_energy_title.draw(x, y, @z, false)
			@red_next_energy_value.draw(x + value_margin, y, @z, false)
			y += 30
			@red_next_wizard_title.draw(x, y, @z, false)
			@red_next_wizard_value.draw(x + value_margin, y, @z, false)
			
			x = $screen_width / 2 + 50
			y = $screen_height + 10
			@blue_title.draw(x, y, @z, false)
			y += 30
			@blue_energy_title.draw(x, y, @z, false)
			@blue_energy_value.draw(x + value_margin, y, @z, false)
			y += 30
			@blue_next_energy_title.draw(x, y, @z, false)
			@blue_next_energy_value.draw(x + value_margin, y, @z, false)
			y += 30
			@blue_next_wizard_title.draw(x, y, @z, false)
			@blue_next_wizard_value.draw(x + value_margin, y, @z, false)
		else
			@winner_title.draw($screen_width / 2, $screen_height + 30, @z)
			@winner_subtitle.draw($screen_width / 2, $screen_height + 100, @z)
		end
	end
end

class EnergyManager
	def initialize
		@energies = []
	end
	
	def update
		@energies.each { |energy| energy.update }
		$sound_manager.play_destroy_energy if @energies.reject! { |energy| energy.points < 0 }
	end
	
	def draw(positions)
		@energies.each { |energy| energy.draw(positions[energy.position][0], positions[energy.position][1]) }
	end
	
	def reset!
		@energies = []
	end
	
	def enough_points?(team, required)
		current = current_points(team)
		log "points required: " + required.to_s
		log "current points: " + current.to_s
		return true if current >= required
		return false
	end
	
	def spend_points(team, amount)
		energies = @energies.select { |energy| energy.team == team }
		total_points = energies.collect { |energy| energy.points }.inject(0, :+)
		log "amount to spend: " + amount.to_s
		log "total points: " + total_points.to_s
		ratios = energies.collect { |energy| energy.points.to_f / total_points.to_f }
		decreased = 0
		for i in 0..energies.length - 1
			to_decrease = (amount.to_f * ratios[i].to_f).floor
			log "decreasing " + to_decrease.to_s + " points"
			energies[i].points -= to_decrease
			energies[i].points = 0 if energies[i].points < 0
			decreased += to_decrease
		end
		if decreased < amount
			energies[ratios.index(ratios.max)].points -= (amount - decreased)
			energies[ratios.index(ratios.max)].points = 0 if energies[ratios.index(ratios.max)].points < 0
			log "decreasing error margin " + (amount - decreased).to_s
		end
	end
	
	def current_points(team)
		energies = @energies.select { |energy| energy.team == team }
		points = energies.collect { |energy| energy.points }.inject(0, :+)
		return points
	end
	
	def biggest_energy(energies)
		#energies = @energies.select { |energy| energy.team == team }
		biggest_energy = energies.max_by { |energy| energy.points }
		return biggest_energy
	end
	
	def current_energies(team)
		energies = @energies.select { |energy| energy.team == team }
		return energies.length
	end
	
	def next_energy_cost(team)
		energies = @energies.select { |energy| energy.team == team }
		#multiplier = energies.length / $step_energy_cost
		multiplier = energies.length
		return $base_energy_cost * multiplier * multiplier
	end
	
	def next_wizard_cost(team)
		wizards = @energies.collect { |energy| energy.wizards_allies + energy.wizards_enemies }.flatten
		wizards = wizards.select { |wizard| wizard.team == team }
		multiplier = (wizards.length / $step_wizard_cost) + 1
		#multiplier = wizards.length
		return $base_wizard_cost * multiplier
	end
	
	def free_position?(position)
		ret = @energies.select { |energy| energy.position == position }
		return true if ret.length == 0
		return false
	end
	
	def spawn_neutral_energy(position, points)
		wall = Energy.new(:neutral, position)
		wall.points = points
		@energies << wall
	end
	
	def spawn_energy(team, position, free = false)
		energy = @energies.select { |energy| energy.position == position }[0]
		return if energy != nil
		
		return if !enough_points?(team, next_energy_cost(team)) and !free
		spend_points(team, next_energy_cost(team)) if !free
		log "[" + team.to_s + "] new energy position: " + position.to_s
		energy = Energy.new(team, position)
		energy.points = next_energy_cost(team) / 2
		@energies << energy
		$sound_manager.play_spawn_energy
		
		spawn_wizard(team, position, true)
		
		return true
	end
  
	def spawn_wizard(team, position, free = false)
		energy = @energies.select { |energy| energy.position == position }[0]
		return if energy == nil
		if energy.has_free_slots?
			return if !enough_points?(team, next_wizard_cost(team)) and !free
			spend_points(team, next_wizard_cost(team)) if !free
			
			wizard = Wizard.new(team)
			wizard.angle = energy.get_free_slot
			energy.add_wizard(wizard, wizard.team == energy.team)
			$sound_manager.play_spawn_wizard
			log "[" + team.to_s + "] new wizard at " + position.to_s + "	[" + (wizard.team == energy.team ? "friendly" : "attacker") + "]"
		else
			return if selected_energy(position).team == team
			current_wizard = energy.get_random_wizard((team == :blue ? :red : :blue))
			log current_wizard if current_wizard != nil
			return if current_wizard == nil
			return if !enough_points?(team, next_wizard_cost(team) * 2) and !free
			spend_points(team, next_wizard_cost(team) * 2) if !free
			wizard = Wizard.new(team)
			wizard.angle = current_wizard.angle
			replace_wizard(energy, current_wizard, wizard)
			$sound_manager.play_attack
			log "[" + team.to_s + "] replaces wizard at " + position.to_s + "	[" + (wizard.team == energy.team ? "friendly" : "attacker") + "]"
		end
	end
	
	def attack_energy(cursor, positions)
		energy = selected_energy(cursor.position)
		visibles = energies_with_direct_vision(energy, cursor.team, positions)
		return if visibles.length == 0
		biggest_energy = biggest_energy(visibles)
		return if energy.points <= 0
		return if biggest_energy.points <= 0
		
		attack = AttackEffect.new(positions[biggest_energy.position], positions[energy.position], cursor.team)
		amount = energy.points < biggest_energy.points ? energy.points + 1 : biggest_energy.points
		energy.points -= amount
		biggest_energy.points -= amount
		
		log "[" + cursor.team.to_s + "] attacked from " + biggest_energy.position.to_s + " to " + energy.position.to_s + " with " + amount.to_s + " points"
		$sound_manager.play_attack
		return attack
	end
	
	def replace_wizard(energy, current_wizard, wizard)
		energy.remove_wizard(current_wizard, energy.team == current_wizard)
		energy.add_wizard(wizard, energy.team == wizard.team)
	end
	
	def selected_energy(position)
		energy = @energies.select { |energy| energy.position == position }[0]
		return energy
	end
	
	def energies_with_direct_vision(target_energy, team, positions)
		energies = @energies.select { |energy| energy.team == team }
		energies.reject! { |energy| 
			origin = positions[energy.position]
			destiny = positions[target_energy.position]
			hit = Ray.new(origin, destiny, @energies, positions).launch!
			!hit or hit.position != target_energy.position
		}
		return energies
	end
end

class SoundManager
	def initialize
		path = File.dirname($0) + "/"
		log "path: " + path
		@music = Gosu::Song.new(path + "bgmusic.ogg") 
		@spawn_energy = Gosu::Sample.new(path + "energy.wav")
		@spawn_wizard = Gosu::Sample.new(path + "wizard.wav")
		@attack = Gosu::Sample.new(path + "attack.wav")
		@destroy_energy = Gosu::Sample.new(path + "explosion.wav")
		@cursor = Gosu::Sample.new(path + "cursor.wav")
	end
	
	def start_music
		@music.play(true)
	end
	
	def stop_music
		@music.stop if @music.playing?
	end

	def play_spawn_energy
		@spawn_energy.play
	end

	def play_spawn_wizard
		@spawn_wizard.play
	end
	def play_attack
		@attack.play
	end

	def play_destroy_energy
		@destroy_energy.play
	end

	def play_move_cursor
		@cursor.play(0.5)
	end

end


$screen_width = 850
$screen_height = 550
$tile_size = 50
$real_screen_width = $screen_width
$real_screen_height = $screen_height + $tile_size * 3


$base_energy_cost = 100
$base_wizard_cost = 5
$step_energy_cost = 1
$step_wizard_cost = 3

$sound_manager = SoundManager.new

class GameWindow < Gosu::Window
	def initialize
		super $real_screen_width, $real_screen_height
		self.caption = "Wizardz"
		
		@row_size, @col_size, @positions = calculate_positions
		
		@background = Background.new(0, 0, $screen_width, $screen_height, 50, Gosu::Color.argb(0xff808080), Gosu::Color.argb(0xff505050), 0)
		@energy_manager = EnergyManager.new
		@ui = UI.new(10)
		@attacks = []
		restart_game!
	end

	def needs_cursor?
		return true
	end
  
	def button_down(id)
		if @playing
			execute_action(@red_cursor) if id == Gosu::KbSpace
			execute_action(@blue_cursor) if id == Gosu::KbReturn
			
			move_cursor(@blue_cursor, :up) if id == Gosu::KbUp
			move_cursor(@blue_cursor, :down) if id == Gosu::KbDown
			move_cursor(@blue_cursor, :left) if id == Gosu::KbLeft
			move_cursor(@blue_cursor, :right) if id == Gosu::KbRight
			
			move_cursor(@red_cursor, :up) if id == Gosu::KbW
			move_cursor(@red_cursor, :down) if id == Gosu::KbS
			move_cursor(@red_cursor, :left) if id == Gosu::KbA
			move_cursor(@red_cursor, :right) if id == Gosu::KbD
		else
			restart_game! if id == Gosu::KbReturn
		end
	end
  
	def update
		self.caption = "Wizardz (FPS " + Gosu::fps.to_s + ")"
		@energy_manager.update
		@blue_cursor.update
		@red_cursor.update
		@ui.update(@energy_manager)
		@attacks.reject! { |attack| attack.update }
		finish!(:blue) if @energy_manager.current_energies(:red) == 0
		finish!(:red) if @energy_manager.current_energies(:blue) == 0
	end

	def draw
		@background.draw
		@energy_manager.draw(@positions)
		@blue_cursor.draw(@positions[@blue_cursor.position][0], @positions[@blue_cursor.position][1], 5)
		@red_cursor.draw(@positions[@red_cursor.position][0], @positions[@red_cursor.position][1], 5)
		@attacks.each { |attack| attack.draw(4) }
		@ui.draw
	end
	
	def calculate_positions
		x = ($tile_size * 1.5).step($screen_width - ($tile_size * 1.5), 100).to_a
		y = ($tile_size * 1.5).step($screen_height - ($tile_size * 1.5), 100).to_a
		
		pos = []
		for i in 0..x.length - 1
			for j in 0..y.length - 1
				pos << [x[i], y[j]]
			end
		end
		
		return x.length, y.length, pos
	end
	
	def move_cursor(cursor, direction)
		$sound_manager.play_move_cursor
		cursor.position = ((cursor.position + 1) % @positions.length) if direction == :down
		cursor.position = ((cursor.position - 1) % @positions.length) if direction == :up
		cursor.position = ((cursor.position - @col_size) % @positions.length) if direction == :left
		cursor.position = ((cursor.position + @col_size) % @positions.length) if direction == :right
	end
	
	def execute_action(cursor)
		if @energy_manager.free_position?(cursor.position)
			@energy_manager.spawn_energy(cursor.team, cursor.position) 
			return
		end
		if !@energy_manager.free_position?(cursor.position)
			selected = @energy_manager.selected_energy(cursor.position)
			@energy_manager.spawn_wizard(cursor.team, cursor.position) if selected.team == cursor.team
			if selected.team != cursor.team
				attack = @energy_manager.attack_energy(cursor, @positions) 
				@attacks << attack if attack
			end
		end
	end
	
	def create_starting_energy(cursor)
		@energy_manager.spawn_energy(cursor.team, cursor.position, true)
		#@energy_manager.spawn_wizard(cursor.team, cursor.position, true)
	end
	
	def finish!(winner)
		@playing = false
		@ui.set_winner(winner)
	end
	
	def restart_game!
		@energy_manager.reset!
		@ui.reset!
		@blue_cursor = Cursor.new(@positions.length - @col_size / 2 - 1, :blue)
		@red_cursor = Cursor.new((@col_size / 2).to_i, :red)

		@energy_manager.spawn_neutral_energy(15, 100)
		@energy_manager.spawn_neutral_energy(16, 250)
		@energy_manager.spawn_neutral_energy(17, 500)
		@energy_manager.spawn_neutral_energy(18, 250)
		@energy_manager.spawn_neutral_energy(19, 100)
		
		@energy_manager.spawn_neutral_energy(20, 100)
		@energy_manager.spawn_neutral_energy(21, 250)
		@energy_manager.spawn_neutral_energy(22, 500)
		@energy_manager.spawn_neutral_energy(23, 250)
		@energy_manager.spawn_neutral_energy(24, 100)
		
		create_starting_energy(@blue_cursor)
		create_starting_energy(@red_cursor)
		$sound_manager.stop_music
		$sound_manager.start_music
		@playing = true
	end
end

window = GameWindow.new
if not defined?(Ocra)
	window.show
end