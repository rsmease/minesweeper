require_relative 'board'

class MinesweeperGame

  def initialize(board = Board.new)
    @board = board
    @turn_count = 0
  end

  def play_round
    until win? || lose?
      @board.render
      puts "Please pick a position."
      pos = get_position
      until valid_position?(pos)
        puts "Oops, that's not a valid position."
        puts "Please pick another position."
        pos = get_position
      end
      selected_tile = @board[pos]
      selected_tile.reveal
      if @board.is_mine?(selected_tile)
        @board.mine_found!
      end
      @turn_count += 1
    end
    if win?
      puts "You win!"
    else
      puts "You lost!"
    end
  end

  def win?
    @turn_count == 4
  end

  def lose?
    @board.bomb_revealed?
  end

  def get_position
    gets.chomp.split(",").map(&:to_i)
  end

  def valid_position?(pos)
    return true unless @board[pos] == false ||
      @board[pos].revealed
    false
  end

end

game1 = MinesweeperGame.new
game1.play_round
