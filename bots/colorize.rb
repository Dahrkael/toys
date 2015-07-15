frase = gets.chomp

frase2 = frase.split(//)

colores = [	"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"10",
		"11",
		"12",
		"13",
		"14",
		"15"
		]
colorizado = []
for i in 0...frase2.size
	colorizado << colores[rand(colores.size)]
	colorizado << frase2[0]
	frase2.slice!(0)
end
puts colorizado.to_s

#File.open("pintado.txt", 'w+') { |x| x.write colorizado }

exec "echo #{colorizado.to_s} | clip" 
