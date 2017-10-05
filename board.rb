class Board
  attr_accessor :grid
  DIFFICULTY = 10
  def initialize(grid = self.create_grid)
    @grid = grid
  end

  def create_grid
    Array.new(9) { Array.new(9, 0) }
  end

  def render
    print "Your board looks like this—\n"
    @grid.each do |row|
      print "#{row.join(" ")}\n"
    end
  end

  def populate_mines
    #NOTE: Does not check for redundancy 
    DIFFICULTY.times do
      @grid[rand(@grid.length)][rand(@grid.length)] = 1
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end

end

my_board = Board.new
pos = [3, 8]
my_board[pos] = 1
my_board.render
my_board.populate_mines
my_board.render
