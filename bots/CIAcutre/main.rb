#!/usr/bin/env ruby

require 'socket'
# Clase principal
class CIAcutre
	
	# Definicion inicial al puntear CIAcutre
	def initialize(servidor, puerto)
		
		@servidor = servidor
		@puerto = puerto
		#@servidor = "irc.freenode.net"
		#@puerto = 6667
		
		@nick = "cutreCIA"
		@nombre = "Bottie"
		@canal = "easyrpg"
		@contrasena = ""
		@saludo_inicial = "Bottie listo para ayudar"
		
		@tiempo = Time.now
		@tiempo2 = @tiempo + (60 * 5)
		
		# Cargamos las revisiones
		@ruta_svn = Dir.chdir("/home/subversion/svn")
		@ruta_db = "#{@ruta_svn}/db"
		@ruta_revs = "#{@ruta_svn}/db/revprops/0"
		
		# Cargar numero de revisiones
		if File.exist?("#{@ruta_db}/current")
			@revlinea = IO.readlines[0]
		else 
			@revlinea = "no hay revisiones disponibles"
		end
		
		@comprobar = @revlinea
		# Establecer conexion
		@conexion = TCPSocket.new(@servidor, @puerto)
		# Enviar nick, nombre y canal al que entrar
		enviar "NICK #{@nick}"
		enviar "USER loler 0 * loler"
		enviar "JOIN ##{@channel}"
		# Si el nick esta registrado
		#enviar "PRIVMSG NickServ :identify #{@contrasena}"
		
		# Saludar al entrar al canal
		hablar(@saludo_inicial)
	end
	
	# Interactividad basica con el servidor
	def enviar(mensaje)
		@conexion.puts mensaje
	end
	
	# Mensajes de canal
	def hablar(mensaje)
		enviar "PRIVMSG ##{@canal} :#{mensaje}"
	end
	
	# Lectura de Revisiones
	def leer_revisiones
	   if File.exist?("#{@ruta_db}/current")
		@revlinea = IO.readlines[0]
		@revlinea2 = @revlinea.to_i - 1
		@revision = File.open("#{@ruta_revs}/#{@revlinea}", 'r') { |f| f.readlines[4, 8, 12] }
		@revision_anterior = File.open("#{@ruta_revs}/#{@revlinea2}", 'r') { |f| f.readlines[4, 8, 12] }
	    else
		@revlinea = "0"
		@revision = "No hay revisiones"
		@revision_anterior = "No hay revisiones anteriores"
	   end
       end

	# Bucle de acciones del bot
	# Cada bloque se activa al coincidir parte del mensaje con lo señalado.
	# El uso de next permite una sola respuesta por vuelta del bucle
	def bucle_principal
		
		# Mientras haya conexion
		until @conexion.eof? do
		
		@tiempo3 = Time.now
		if @tiempo2 == @tiempo3
			leer_revisiones
			@tiempo = @tiempo2
			@tiempo2 = @tiempo + (60 * 5)
		end
		# Mensajes recibidos
		mensaje = @conexion.gets
		if @revlinea != @comprobar
			hablar("Rev:#{@revlinea}: #{@revision}")
			next
		end
		
		# Pasamos los mensajes a minusculas para evitar canis
		mensaje_minusculas = mensaje.downcase
		# Guardar historial - desactivado
	        #File.open(Time.new.strftime('%d-%B-%Y-historial.txt'), 'a+') { |f| f.write(mensaje) }
		
		# Si hacen ping
		if mensaje.match(/^PING :(.*)$/)
			enviar "PONG #{$~[1]}"
			next
		end
		
		# Si recibimos un mensaje del canal sea cual sea (.*) contestar - desactivado
		#if mensaje_minusculas.match(/PRIVMSG ##{@canal} :(.*)$/)
		#	hablar('mensaje a enviar')
		#	next
		#end
		
		# Si piden la ultima revision se la damos
		if mensaje_minusculas.match(/privmsg ##{@canal} :cutrecia(.*)ultima revision$/)
			hablar("Rev:#{@revlinea}: #{@revision}")
			next
		end
		# Si piden la penultima revision se la damos
		if mensaje_minusculas.match(/privmsg ##{@canal} :cutrecia(.*)anterior revision$/)
			hablar("Rev:#{@revlinea2}: #{@revision_anterior}")
			next
		end
		# Si piden la cantidad de revisiones se la damos
		if mensaje_minusculas.match(/privmsg ##{@canal} :cutrecia(.*)numero de revisiones$/)
			hablar("Numero de revisiones: #{@revlinea}")
			next
		end
		
	    end # Fin del bucle
      end # Fin del metodo del bucle
end
    
ircbot = CIAcutre.new("irc.freenode.net", 6667)

ircbot.bucle_principal