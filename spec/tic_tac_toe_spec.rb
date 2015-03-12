require 'tic_tac_toe'

describe TicTacToe do

	let(:game){TicTacToe.new("bob", Array.new(9))}

	before do
		allow(game.grid).to receive(:all_winning_indexes).and_return([[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]])
	end

	it "can have a grid of 9" do
		expect(game.grid.count).to eq 9
	end

	it "can know if a game is not over" do
		expect(game.winner?).to eq false
	end

	it "can know if a game is over onces there is a row of x's" do
		fill_indexes([0,1,2], with: "x")
		expect(game.winner?).to eq true
	end

	it "can know if a game is over once there is a vertial of x's" do
		fill_indexes([0,3,6], with: "x")
		expect(game.winner?).to eq true
	end

	it "can know if a game is over once there is a diaganol of x's" do
		fill_indexes([0,4,8], with: "x")
		expect(game.winner?).to eq true
	end

	it "can register an opponent" do
		expect(game.opponent).to eq "bob"
	end

	it "will know whos turn it is" do
		expect(game.turn).to eq "bob"
	end

	it "will register a go for the oppoennt with an x" do
		game.send(:go,1)
		expect(game.grid[1]).to eq "x"
	end

	it "will switch turns onces  a go is registered" do
		game.send(:go,1)
		expect(game.turn).to eq game
	end

	it "will take a turn after the person has taken a go" do
		game.send(:go,1)
		game.go
		expect(game.grid.select{|i| i =="o"}).to eq ["o"]
	end

	it "won't let a go happen if the game has a winner" do
		fill_indexes([0,1,2], with: "x")
		expect{game.send(:go,3)}.to raise_error "Can't, games over"
	end

	it 'can know the best move to make' do
		fill_indexes([0], with: "x")
		expect(game.best_position).to eq 4
	end

	it "can know how many directions it can win" do
		expect(game.directions_to_win_count 4).to eq 4
	end

	it "doesnt plot if itself is there" do
			fill_indexes([0], with: "x")
			fill_indexes([4], with: "o")
			expect(game.best_position).to eq 2
	end

	it "can know how many dirctions it can when a directions is blocked off" do
		fill_indexes([0], with: "x")
		expect(game.directions_to_win_count 4).to eq 3
	end

	it "should know if a route is blocked" do
		fill_indexes([0], with: "x")
		route = [0,1,2]
		expect(game.route_blocked?(route)).to eq true
	end

	it "should know if a route is not blocked" do
		route = [0,1,2]
		expect(game.route_blocked?(route)).to eq false
	end

	it "should return the remainding index of a board which is about to win or lose" do
		fill_indexes([0,1], with: "x")
		expect(game.last_cell_in_section).to eq 2
	end

	it "should either block a move or win the game if it needs to " do
		fill_indexes([0,6], with: "x")
		expect(game.best_position).to eq 3
	end


	def fill_indexes(indexes, with: "x")
		indexes.each {|index| game.grid[index] = with}
	end
end