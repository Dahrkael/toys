#!/usr/bin/ruby

require 'socket'
require 'main.rb'

ircbot = CIAcutre.new("irc.freenode.net", 6667)

ircbot.bucle_principal