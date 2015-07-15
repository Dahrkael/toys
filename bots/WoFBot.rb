#!/usr/bin/env ruby

require 'socket'

class SimpleIrcBot

  def initialize(server, port, channel, nick)
    
    
    @channel = "ofarts"
    @nick = nick
    @socket = TCPSocket.open(server, port)
    say "NICK #@nick"
    say "USER WoFBot 0 * WoFBot"
    say "JOIN ##{@channel}"
  end

  def say(msg)
    @socket.puts msg
  end

  def say_to_chan(msg)
    say "PRIVMSG ##{@channel} :#{msg}"
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      histo = msg
      histo.gsub!(":", "")
      histo.gsub!(/!(.*)PRIVMSG ##{@channel}/, "")
      histo += "-->"
      File.open(Time.new.strftime('%d-%B-%Y-historial.txt'), 'a+') {|f| f.write(histo) }
      

      if msg.match(/^PING :(.*)$/)
        say "PONG #{$~[1]}"
        next
      end

     # if msg.match(/PRIVMSG ##{@channel} :(.*)$/)
       #   say_to_chan('Viva el pr0n')
       #   next
       # end
        

        


    end
  end

  def quit
    say "PART ##{@channel} :Hasta luego!"
    sleep(0.8)
    say 'QUIT'
  end
end

bot = SimpleIrcBot.new("irc.freenode.net", 6667, '#ofarts', "WoFbot")

trap("INT"){ bot.quit }

bot.run
