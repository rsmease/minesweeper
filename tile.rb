class Tile
  attr_accessor :value, :revealed
  def initialize(revealed = false)
    @revealed = revealed
    @value = 0
  end

  def mine?
    @value == "X"
  end

  def reveal
    p "Tile revealed"
    @revealed = true
  end

  def show
    if @revealed
      return @value
    else
      return "\#"
    end
  end
end
