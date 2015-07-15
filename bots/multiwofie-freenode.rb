#!/usr/bin/env ruby

require 'socket'
require 'open-uri'
$KCODE = 'u'
begin
class SimpleIrcBot
#-------------------------------------------------------------------------------------------------------
  def initialize(server, port, channel, nick)
	@respuestas = ["i'll never tell you!",
	"maybe shadow o.0",
	"stfu and give me a joint >:|",
	"error processing request... fuck you",
	"...",
	"err... a monkey!",
	"so beautiful",
	"silence! i kill you!",
	"I wont tell you",
	"i dont know but, where are my trousers?"]
	
	@caras = [":O", ";o", ":D", ";D", ":)", ";)", ":(", ";(", "o.O", "O.o", "o.0", ":P", "<.<", ">.<"]
	
	@delitos = ["teaching the replicators to make decaffinated beverages",
			"improper use of the entire crew",
			"setting fire to the Crystalline Entity(tm)",
			"having sex with the USS Voyager",
			"timetravelling without a safety net",
			"terraforming Neelix",
			"improper conduct with a class Y planet",
			"phase-shifting the entire crew",
			"attempting to replicate Deanna Troi",
			"plotting with Lt Cmdr Tuvok",
			"improper conduct with a class Y planet",
			"improper use of Lt Cmdr Tuvok",
			"setting fire to Deputy Wall Licker 97th Class Splock",
			"existing",
			"improper use of a proton",
			"misuse of Dr Crusher",
			"having sex on a shuttle",
			"putting the entire female crew into suspended animation",
			"doing warp 5 in a 3 zone",
			"phase-shifting Neelix",
			"phase-shifting the phaser bank",
			"having sex on the holodeck",
			"abusing the suck'n'fuck ability of muff",
			"and improperly docking with the USS Defiant"]
	
	@sentencias = ["polish Captain Picard's head. And may God have mercy on your soul. ",
				"talk to Neelix for 5 hours. And may God have mercy on your soul.",
				"fuck with wyatt. And may God have mercy on your penis",
				"die. And may God have mercy on your soul.",
				"be hacked by a chinese n00b. And may God have mercy on your ip.",
				"mmm.. lets see...sing a song. And may God have mercy on your soul.",
				"polish the EMH's head. And may God have mercy on your soul.",
				"be smashed on the floor by Hulk Hogan. And may God have mercy on your soul.",
				"explain quantum physics to Jade. And may God have mercy on your soul.",
				"spys Arbiters sister and take photos. And may God have mercy on your soul.",
				"be keel-dragged through an asteriod field. And may God have mercy on your soul."]
	
	@channel = channel
	@nick = nick
	@socket = TCPSocket.open(server, port)
    say "NICK #{@nick}"
    say "USER WoFie 0 * WoFie"
    say "JOIN ##{@channel}"
    
  end
#-------------------------------------------------------------------------------------------------------------
	def say(msg)
	puts msg
	@socket.puts msg
	end
	def say_to_chan(msg)
		say("PRIVMSG ##{@nao} :#{msg}")
	end
	def get_title(thing)
		begin
		titulo = "sin titulo"
		open(thing) {|f|
			f.each_line {|line| 
			if line.match(/<title>(.*)<\/title>/i)
				titulo = $1
				return titulo
			end
			}
		}
		return titulo
		rescue
		return "URL is unnaccesible"
		end
	end
	def get_chiste
		begin
		open("http://www.chistes.com/ChisteAlAzar.asp") {|f|
			f.each_line {|line| 
				if line.match("<div class=\"chiste\">") and line.match("</div>")
					line.gsub!("<div class=\"chiste\">","")
					line.gsub!("</div>","")
					@chiste.push(line)
					puts line
				elsif line.match("<div class=\"chiste\">") and not line.match("</div>")
					line.gsub!("<div class=\"chiste\">","")
					line.gsub!("<BR>","")
					@chiste.push(line)
					puts line
				end
				if line.match("<BR>")
					line.gsub!("<BR>","")
					@chiste.push(line)
					puts line
				end
				if line.match(".</div>") and not line.match("div id=\"title\">") and not line.match("div class=\"clasificacion\">") and not line.match("div id=\"fb-root\">")
					line.gsub!("</div>","")
					@chiste.push(line)
					puts line
				end	
			}
		}
		rescue
		return "No hay chistes disponibles"
		end
	end


	#def google_search(thing)
	#	google = open("http://google.es/search?q=#{thing}").read
		#pos_euro = google.index("<!--m-->")
		#pos_dolar = google.index("<!--m-->")
	#end
#-----------------------------------------------------------------------------------------------------------------
  def run
	while true
   # until @socket.eof? do
      msg = @socket.gets
      puts msg
      msg.chop!
      #File.open(Time.new.strftime('%d-%B-%Y-historial.txt'), 'a+') {|f| f.write(msg) }
      

	if msg.match(/^PING (.*)$/)
		say "PONG #{$~[1]}"
		next
	end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG (([A-Z]|[a-z]|[0-9]|-|_)*) :VERSION$/i)
		say("NOTICE #{$1} :VERSION Ruby-IRCClient v1WoFie")
		next
	end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG (([A-Z]|[a-z]|[0-9]|-|_)*) :PING\s?(.*)?$/i)
		say("NOTICE #{$1} :PONG #{$6}")
		next
	end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :.login(.*)$/)
	#	say("NOTICE #{$1} :Pass auth failed (#{$1}!#{$2}@#{$3}).")
	#	say("NOTICE #{$1} :Your attempt has been logged.")
	#	next
	#end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :&help$/)
	#	@nao = $4
	#	say("NOTICE #{$1} :Commands:")
	#	say("NOTICE #{$1} :&help - show this help")
	#	say("NOTICE #{$1} :.login pass - DDoSbot")
	#	say("NOTICE #{$1} :!quit - quits the bot")
	#	say("NOTICE #{$1} :!host - show your host")
	#	say("NOTICE #{$1} :!joke - cuenta un chiste")
	#	say("NOTICE #{$1} :!op - gives you op")
	#	say("NOTICE #{$1} :!deop - quits you op")
	#	say("NOTICE #{$1} :!v - gives you voice")
	#	say("NOTICE #{$1} :!dv - quits you voice")
	#	say("NOTICE #{$1} :!kick nick - kicks that user")
	#	say("NOTICE #{$1} :!kb nick - kick and ban that user")
	#	say("NOTICE #{$1} :!ub nick - unban that nick")
	#	#say_to_chan("!nick nick - changes the bots nick")
	#	say("NOTICE #{$1} :!topic topic - changes the channel topic")
	#	say("NOTICE #{$1} :!say string - send the string to the channel")
	#	say("NOTICE #{$1} :!flood - >:|")
	#	say("NOTICE #{$1} :WoFie courtmartial nick - :)")
	#	say("NOTICE #{$1} :!server ip port #channel - changes the connected server")
	#	say("NOTICE #{$1} :!channel channel - joins the bot on the channel")
          #next
	#end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :!quit$/)
		if $1 == "Dahrkael"
			quit
		end
          next
	end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :!rodadora$/)
	#	@nao = $4
	#	sleep(0.4)
	#	say_to_chan(".......................................")
	#	sleep(0.4)
	#	say_to_chan(".@.....................................")
	#	sleep(0.4)
	#	say_to_chan("..........@............................")
	#	sleep(0.4)
	#	say_to_chan("......................@................")
	#	sleep(0.4)
	#	say_to_chan("..................................@....")
	#	sleep(0.4)
	#	say_to_chan(".......................................")
          #next
	#end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :(.*)([h|H]ttp:\/\/(.*)\.?(.*)\.([a-z]*)?)(.*)\s?/)
		@nao = $4
		#if $1 == "fdelapena" or $1 == "Soeufans"
		#	next
		#end
		thing2 = get_title($7+$11)
		say_to_chan(thing2)
          next
	end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :(.*)([h|H]ttp:\/\/(.*)\.?(.*)\.([a-z]*)?)(.*)\s?/)
	#	@nao = $4
	#	if $1 == "fdelapena" or $1 == "Soeufans"
	#		next
	#	end
	#	thing2 = get_title($7+$11)
	#	say_to_chan(thing2)
        #  next
	#end
#	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :[W|w][O|o][F|f][I|i][E|e](.?) (.*)\?$/) or msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :(.*)[W|w][O|o][F|f][I|i][E|e](.?) (.*)\?$/) or msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :(.*)[W|w][O|o][F|f][I|i][E|e]\?$/)
#			sleep(rand(5))
#			#say("PRIVMSG ##{$4} :#{$5}#{$6}")
#			say("PRIVMSG ##{$4} :#{@respuestas[rand(@respuestas.size-1)]}")
#		next
	#end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :(:|;|o|0|O|<|>)(.*)$/)
		if rand(3) == 2
			sleep(rand(4))
			#say("PRIVMSG ##{$4} :#{$5}#{$6}")
			say("PRIVMSG ##{$4} :#{@caras[rand(@caras.size-1)]}")
		end
		next
	end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :([A-Z]+)(\s[A-Z]+)*(!*)$/)
	#	@nao = $4
	#	if rand(4) == 2
	#		say("PRIVMSG ##{$4} :ACTION is blown away by force of #{$1}'s statement")
	#	end
          #next
	#end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :ACTION gives [W|w][O|o][F|f][I|i][E|e](.?) a joint$/)
	#	@nao = $4
	#	sure = rand(4)
	#	if sure == 2
	#		say("PRIVMSG ##{$4} :ACTION smokes it")
	#		elsif sure == 3
	#		say("PRIVMSG ##{$4} :thanks bro")
	#		elsif sure == 1
	#		say("PRIVMSG ##{$4} :Hey! thats not a joint! >:|")
	#		elsif sure == 0
	#		say("PRIVMSG ##{$4} :nah, i cant with more")
	#	end
          #next
	#end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :ACTION tickles [W|w][O|o][F|f][I|i][E|e](.?)$/)
	#	@nao = $4
	#	sure = rand(4)
	#	if sure == 2
	#		say("PRIVMSG ##{$4} :ACTION feels horny")
	#		elsif sure == 3
	#		say("PRIVMSG ##{$4} :hey! STOP!!!")
	#		elsif sure == 1
	#		say("PRIVMSG ##{$4} :are you sure you want to do it ¬¬")
	#		sleep(2)
	#		say("PRIVMSG ##{$4} :ACTION charges the shotgun")
	#		elsif sure == 0
	#		say("PRIVMSG ##{$4} :i hate you ;o;")
	#	end
         # next
	#end
	
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :[W|w][O|o][F|f][I|i][E|e](.?) courtmartial (.*)$/)
	#	@nao = $4
	#	say("PRIVMSG ##{$4} :ACTION throws #{$7} in the brig to await charges ")
	#	sleep(5)
	#	say("PRIVMSG ##{$4} :#{$7}, you are charged with #{@delitos[rand(@delitos.size-1)]}, and #{@delitos[rand(@delitos.size-1)]}")
	#	sleep(10)
	#	sentencia= rand(3)
	#	if sentencia == 2
	#		say("PRIVMSG ##{$4} :You have been found innocent, have a nice day.")
	#	else
	#		say("PRIVMSG ##{$4} :You have been found guilty, and are sentenced to #{@sentencias[rand(@sentencias.size-1)]}")
	#	end
         # next
	#end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :!host$/)
	#	@nao = $4
	#	say_to_chan("Your host is #{$3}")
          #next
	#end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :!joke$/)
		@nao = $4
		@chiste = []
		get_chiste
		@chiste.slice!(0)
		@chiste.slice!(0)
		@chiste.slice!(0)
		@chiste.slice!(0)
		while @chiste.size > 8
			get_chiste
		end
		for i in 0...@chiste.size
			say_to_chan(@chiste[i])
		end
          next
	end
        if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :!op$/)
           say("MODE ##{$4} +o #{$1}")
          next
	end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :!deop$/)
           say("MODE ##{$4} -o #{$1}")
          next
	end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :!v$/)
           say("MODE ##{$4} +v #{$1}")
          next
	end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :!dv$/)
           say("MODE ##{$4} -v #{$1}")
          next
	end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :!kick (.*)$/)
	#	say("KICK ##{$4} #{$6}")
	#	next
	#end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :!kb (.*)$/)
	#	say("MODE ##{$4} +b #{$6}")
	#	say("KICK ##{$4} #{$6}")
	#	next
	#end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :!ub (.*)$/)
		say("MODE ##{$4} -b #{$6}")
		next
	end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :!nick (.*)$/)
	#	say("NOTICE #{$1} Changing nick")
	#	say("NICK #{$6}")
	#	next
	#end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z]|\.)*) :!topic (.*)$/)
		say("NOTICE #{$1} :setting the new topic")
		say("TOPIC ##{$4} :#{$6}")
		next
	end
	if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #?(([A-Z]|[a-z]|\.)*) :!server (.*) (.*) (.*)$/)
		if $1 == "Dahrkael"
			say("NOTICE #{$1} :connecting to the new server")
			say("PART ##{$4} :later")
			sleep 0.8
			say("QUIT")
			@socket = TCPSocket.open($6, $7)
			say "NICK #{@nick}"
			say "USER WoFie 0 * WoFie"
			say "JOIN #{$8}"
		end
		next
	end
        if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #?(([A-Z]|[a-z]|\.)*) :!channel #(.*)$/)
		say("NOTICE #{$1} :Joining channel")
		#say "PART ##{@channel} :later"
		@channel = $6
		msg = nil
		say "JOIN ##{@channel}"
		next
        end
         if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG (([A-Z]|[a-z]|\.)*) :!say #(([A-Z]|[a-z])*) (.*)$/)
		 @nao = $6
		say_to_chan("#{$8}")
		next
        end
	#if msg.match(/:(.*)!~(.*)@(.*) PRIVMSG #(([A-Z]|[a-z])*) :!flood/)
	#	sleep(1)
	#	@nao = $4
	#	say_to_chan("no floodins d:o")
	#	next
	#end
########################################################################
########################################################################

    end
  end
#------------------------------------------------------------------------------------------------------
  def quit
    say "PART ##{@channel} :later"
    sleep(0.8)
    say 'QUIT'
  end
end
#-------------------------------------------------------------------------------------------------------
bot = SimpleIrcBot.new("irc.freenode.net", 6667, 'infiniterasa', "WoFie")

trap("INT"){ bot.quit }

bot.run
rescue
end
