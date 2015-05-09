class InvalidMoveError < StandardError
end

class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def move(from, to)
    if @towers[from].empty?
      raise InvalidMoveError
    elsif @towers[to].empty? || @towers[to].last > @towers[from].last
      @towers[to] << @towers[from].pop
    else
      raise InvalidMoveError
    end
  end

  def won?
    @towers.first.empty? && (@towers[1] == [3,2,1] || @towers[2] == [3,2,1])
  end


end
