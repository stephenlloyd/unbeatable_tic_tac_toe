require './lib/tic_tac_toe.rb'
require 'terminal-table'

print "Welcome to Tic Tac Toe\n please enter your name:\n>:"
name = gets.chomp

game = TicTacToe.new(name, Array.new(9))

puts  Terminal::Table.new :rows => game.grid.each_slice(3).to_a
puts "please put the index (0 indexed) of the square you want to hit\n or type 'exit' to exit"

shot = gets.chomp

until game.winner? or  shot == 'exit'
	game.go shot.to_i
	game.go
	puts Terminal::Table.new :rows => game.grid.each_slice(3).to_a
	puts "Your go!"
	shot = gets.chomp
end
