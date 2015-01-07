 class TicTacToe

 	MARKER, OPPONENT_MARKER = "o", "x"

 	attr_reader :grid, :opponent, :turn

 	def initialize opponent
 		@opponent, @turn, @grid = opponent, opponent, Array.new(9)
 	end

 	def winner?
 		all_values.any?{|value| all_marked_the_same?(value)}
 	end

 	def all_values
 		all_routes.map{|route|route.map{|index|grid[index]}}
 	end

 	def go position 
 		raise "Can't, games over" if winner?
 		grid[position] = marker
 		switch_turns 
 	end

 	def all_marked_the_same?(sections)
 		only_one_type?(sections) and none_are_nil?(sections)
 	end

 	def none_are_nil?(sections)
 		!sections.compact.empty?
 	end

 	def only_one_type?(sections)
 		sections.flatten.uniq.count == 1
 	end

 	def two_marked_the_same?(route)
 		values = route.map{|index|grid[index]}.compact
 		values.count == 2 and values.uniq.count == 1
 	end

 	def marker 
 		turn == opponent ? OPPONENT_MARKER : MARKER
 	end

 	def switch_turns
 		@turn = (turn == opponent ? self : opponent)
 	end

 	def take_turn
 		go(best_position)
 	end

 	def best_position
 		last_cell_in_section ? last_cell_in_section : route_with_most_options_to_win
 	end

 	def route_with_most_options_to_win
 		cells_with_possible_routes.max{|a,b|a[:directions] <=> b[:directions]}[:index]
 	end

 	def cells_with_possible_routes
 		(0..8).map{|index| {index: index, directions: directions_to_win_count(index)}}
 	end

 	def directions_to_win_count index
 		routes = all_routes.select{|section| section if (section.include? index) unless route_blocked?(section)}.count
 	end

 	def route_blocked? route
 		route.any?{|index| grid[index] == OPPONENT_MARKER}
 	end

 	def last_cell_in_section
 		routes_missing_one_value.reject{|index| grid[index]}.first
 	end

 	def routes_missing_one_value
 		all_routes.select{|route| two_marked_the_same?(route)}.flatten
 	end

 	def all_routes
 		row_indexes + column_indexes + diagonal_indexes
 	end

 	def row_indexes
 		[*0..8].each_slice(3).to_a
 	end

 	def column_indexes
 		row_indexes.transpose
 	end

 	def diagonal_indexes
 		[[0,4,8],[2,4,6]]
 	end

 end