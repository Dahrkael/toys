#!/usr/bin/env ruby

require 'socket'

class SimpleIrcBot
#-------------------------------------------------------------------------------------------------------
  def initialize(server, port, channel, nick)
    
    @insultos = ['Hijos de puta', 'Cabrones', 'Soplapollas', 'Pagafantas', 'Pazguatos', 'Ojetes']
    @insulto = ['Hijo de puta', 'Cabron', 'Soplapollas', 'Pagafantas', 'Capullo', 'Bastardo']
    @saludo = ['Hola', 'Buenas', 'nas', 'Hey']
    @nombrado = ['si?', 'dime', '?', 'presente', 'cuentame']
    
    @channel = "rpgmaker.es"
    @nick = nick
    @socket = TCPSocket.open(server, port)
    say "NICK #{@nick}"
    say "USER WoFie 0 * WoFie"
    say "JOIN ##{@channel}"
   
  end
#-------------------------------------------------------------------------------------------------------------
  def say(msg)
    @socket.puts msg
  end
#--------------------------------------------------------------------------------------------------------------
  def say_to_chan(msg)
    say "PRIVMSG ##{@channel} :#{msg}"
  end
  def say_to_chan2(msg)
    say "PRIVMSG #hellteam :#{msg}"
  end
#-----------------------------------------------------------------------------------------------------------------
  def run
    until @socket.eof? do
      msg = @socket.gets
      msg2 = msg.downcase
      #File.open(Time.new.strftime('%d-%B-%Y-historial.txt'), 'a+') {|f| f.write(msg) }
      

      if msg.match(/^PING :(.*)$/)
        say "PONG #{$~[1]}"
        next
      end


  
	if msg2.match(/privmsg ##{@channel} :!di(.*)$/)
           msg.gsub!(/(.*)PRIVMSG ##{@channel} :/, "")
           msg.gsub!("!di\s", "")
           say_to_chan2(msg)
          next
  end
  
        if msg2.match(/(.*):dahrkael!n=dahrkael(.*)pirate wofie(.*)$/)
           say "PART ##{@channel} :Hasta luego!"
           sleep(1.5)
           say 'QUIT'
          next
        end
        

        if msg2.match("privmsg ##{@channel} :wofie dame op") and not msg2.match(/:syxtem!(.*)privmsg ##{@channel} :wofie dame op$/) and not msg2.match(/:midgar!(.*)privmsg ##{@channel} :wofie dame op$/)
           msg.gsub!(/!(.*)/, "")
           msg.gsub!(":", "")
           #say("MODE ##{@channel} +o")
           say("MODE ##{@channel} +o #{msg}")
           #say("OP ##{@channel} #{msg}")
          next
        end


        if msg2.match("privmsg ##{@channel} :hola wofie") or msg2.match("privmsg ##{@channel} :buenas wofie") or msg2.match("privmsg ##{@channel} :nas wofie") or msg2.match("privmsg ##{@channel} :hi wofie")
          msg.gsub!(/!(.*)/, "")
          msg.gsub!(":", "")
          sleep(1.5)
          say_to_chan(@saludo[rand(4)]+" "+msg)
          next
        end
        
        if msg2.match("privmsg ##{@channel} :adios wofie") or msg2.match("privmsg ##{@channel} :bye wofie") or msg2.match("privmsg ##{@channel} :cya wofie") or msg2.match("privmsg ##{@channel} :talue wofie")
          msg.gsub!(/!(.*)/, "")
          msg.gsub!(":", "")
          sleep(1.5)
          say_to_chan("adios"+" "+msg)
          next
        end



        
       # if msg2.match("privmsg ##{@channel} :wofie #hellteam")
        #  say_to_chan('Entendido')
       #   say "PART ##{@channel} :Voy al canal mencionado"
        #  @channel = "hellteam"
       #   say "JOIN #hellteam"
       #   next
       # end
        
        #if msg2.match("privmsg ##{@channel} :wofie #ofarts")
        #  say_to_chan('Entendido')
       #   say "PART ##{@channel} :Voy al canal mencionado"
       #   @channel = "ofarts"
       #   say "JOIN #ofarts"
       #   next
       # end
        
       # if msg2.match("privmsg ##{@channel} :wofie #easyrpg")
       #   say_to_chan('Entendido')
       #   say "PART ##{@channel} :Voy al canal mencionado"
       #   @channel = "easyrpg"
       #   say "JOIN #easyrpg"
       #   next
       # end



        if msg2.match("privmsg ##{@channel} :wofie insulta")
          sleep(1.5)
          say_to_chan(@insultos[rand(6)])
          next
        end

        if msg2.match(/privmsg ##{@channel} :(.*)insulta a (.*)$/)
          msg.gsub!(/(.*)insulta a\s/, "")
          sleep(1.5)
          say_to_chan("Eres un "+@insulto[rand(6)]+" "+msg)
          #say_to_chan(@insulto[rand(6)])
          next
        end

      

       if msg2.match(/join(.*)##{@channel}(.*)$/)
         sleep(1.5)
           say_to_chan(@saludo[rand(4)])
        next
      end

       if msg2.match("privmsg ##{@channel} :tio que pone en el mio?")
         sleep(1.5)
          say_to_chan("mola y el mio?")
          next
        end
      
      if msg2.match(/privmsg ##{@channel} :(.*)hijo de puta(.*)$/)
        sleep(1.5)
           say_to_chan("xD")
        next
      end
      
      if msg2.match(/privmsg ##{@channel} :(.*)linux(.*)$/)
        sleep(1.5)
          say_to_chan("Linux Sucks")
          next
        end
      
      if msg2.match(/(.*)se la(.*)$/) or msg2.match(/(.*)chupa(.*)$/) or msg2.match(/(.*)enorme(.*)$/) or msg2.match(/(.*)larg(a|o)(.*)$/) or msg2.match(/(.*)alargad(a|o)(.*)$/)
           sleep(1.5)
           say_to_chan("CACCS")
        next
      end


      
    #  if msg2.match(/privmsg ##{@channel} :wofie$/)
     #   sleep(0.5)
     #      say_to_chan(@nombrado[rand(5)])
    #    next
     # end


########################################################################
########################################################################



        
        if msg2.match(/(.*):dahrkael!n=dahrkael(.*)wofie #hellteam\s(.*)$/)
          say_to_chan('Entendido')
          say "PART ##{@channel} :Voy al canal mencionado"
          @channel = "hellteam"
          say "JOIN #hellteam"
          next
        end
        
        if msg2.match(/(.*):dahrkael!n=dahrkael(.*)wofie #ofarts\s(.*)$/)
          say_to_chan('Entendido')
          say "PART ##{@channel} :Voy al canal mencionado"
          @channel = "ofarts"
          say "JOIN #ofarts"
          next
        end
        
        if msg2.match(/(.*):dahrkael!n=dahrkael(.*)wofie #easyrpg\s(.*)$/)
          say_to_chan('Entendido')
          say "PART ##{@channel} :Voy al canal mencionado"
          @channel = "easyrpg"
          say "JOIN #easyrpg"
          next
        end



        if msg2.match(/(.*):dahrkael!n=dahrkael(.*)wofie insulta\s(.*)$/)
          sleep(1.5)
          say_to_chan(@insultos[rand(6)])
          next
        end

        if msg2.match(/(.*):dahrkael!n=dahrkael(.*)insulta a (.*)$/)
          msg.gsub!(/(.*)insulta a\s/, "")
          sleep(1.5)
          say_to_chan(msg)
          say_to_chan(@insulto[rand(6)])
          next
        end


      
      if msg2.match(/(.*):dahrkael!n=dahrkael(.*)!risa(.*)$/)
        sleep(1.5)
           say_to_chan("xD")
        next
      end
      
      if msg2.match(/(.*):dahrkael!n=dahrkael(.*)!triste(.*)$/)
        sleep(1.5)
           say_to_chan(":_(")
        next
      end
        
        if msg2.match(/(.*):dahrkael!n=dahrkael(.*)!di(.*)$/)
           msg.gsub!(/(.*)PRIVMSG (##{@channel}|#{@nick}) :!di\s/, "")
           sleep(1.5)
           say_to_chan(msg)
          next
        end
        
         if msg2.match(/privmsg ##{@channel} :!di(.*)$/)
           msg.gsub!(/(.*)PRIVMSG ##{@channel} :/, "")
           msg.gsub!("!di\s", "")
           sleep(1.5)
           say_to_chan(msg)
          next
        end
        
      if msg2.match("privmsg ##{@channel} :wofie")
        sleep(1.5)
           say_to_chan(@nombrado[rand(5)])
        next
      end
########################################################################
########################################################################

    end
  end
#------------------------------------------------------------------------------------------------------
  def quit
    say "PART ##{@channel} :Hasta luego!"
    sleep(0.8)
    say 'QUIT'
  end
end
#-------------------------------------------------------------------------------------------------------
bot = SimpleIrcBot.new("irc.freenode.net", 6667, '#rpgmaker.es', "WoFie")

trap("INT"){ bot.quit }

bot.run
