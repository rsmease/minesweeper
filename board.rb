require_relative 'tile'
require 'byebug'
class Board
  attr_accessor :grid
  DIFFICULTY = 0
  def initialize(grid = self.create_grid)
    @grid = grid
    @bomb_revealed = false
  end

  def create_grid
    Array.new(9) { Array.new(9) { Tile.new } }
  end

  def reveal(pos)
    row, col = pos
    @grid[row][col].reveal
  end

  def render
    print "Your board looks like this—\n"
    print "  #{(0...9).to_a.join(" ")}"
    puts
    @grid.each_with_index do |row, i|
      print "#{i} "
      row.each do |col|
        print "#{col.show} "
      end
      print "\n"
    end
  end

  def populate_mines
    #NOTE: Does not check for redundancy
    DIFFICULTY.times do
      @grid[rand(@grid.length)][rand(@grid.length)].value = 'X'
    end
  end

  def [](pos)
    value = @grid[pos[0]][pos[1]]
    value.nil? ? false : value
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]].value = value
  end

  def count_neighbor_mines(pos)
    row, col = pos
    count = 0

    above = @grid[row-1][col-1..col+1]
      .select { |tile| !tile.nil? && tile.mine? }
    count += above.length

    left = @grid[row][col-1]
    right = @grid[row][col+1]
    count += 1 if (!left.nil? && left.mine?)
    count += 1 if (!right.nil? && right.mine?)

    below = @grid[row+1][col-1..col+1]
      .select { |tile| !tile.nil? && tile.mine? }
    count += below.length

    count
  end

  def is_mine?(pos)
    return false if pos.nil?
    row, col = pos
    pos.value == 'X'
  end

  def bomb_revealed?
    @bomb_revealed
  end

  def mine_found!
    @bomb_revealed = true
  end

end



my_board = Board.new
# byebug
pos = [4, 5]
pos2 = [3, 7]
# my_board[pos] = 1
# my_board.render
my_board.populate_mines
my_board.reveal(pos)
p my_board[pos2].revealed
my_board.render
# p my_board.count_neighbor_mines(pos)
