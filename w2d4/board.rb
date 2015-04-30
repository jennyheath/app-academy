require_relative 'piece'
require 'colorize'
require 'byebug'

class CheckerBoard
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos[0], pos[1]
    @grid[row][col] = piece
  end

  def set_board
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        pos = [row_idx, col_idx]
        if row_idx <= 2
          self[pos] = Piece.new(self, :black, pos) if (row_idx - col_idx).even?
        elsif row_idx >= 5
          self[pos] = Piece.new(self, :red, pos) if (row_idx - col_idx).even?
        end
      end
    end
  end

  # def each_tile_with_index(&prc)
  #   @grid.each_with_index do |row, row_idx|
  #     row.each_with_index do |tile, col_idx|
  #       prc.call(row, row_idx, tile, col_idx)
  #     end
  #   end
  # end

  def display
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        if tile.nil?
          print "   ".colorize(background: :black) if (row_idx - col_idx).even?
          print "   ".colorize(background: :red) if (row_idx - col_idx).odd?
        else
          tile.color == :red ? color = :red : color = :white
          print " #{tile.symbol} ".colorize(background: :black, color: color)
        end
      end
      print "\n"
    end
  end

  def dup_board
    test_board = CheckerBoard.new
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        if !tile.nil?
          pos = [row_idx, col_idx]
          test_board[pos] = Piece.new(test_board, tile.color, tile.pos.dup, tile.king)
        end
      end
    end
    test_board
  end
end

game = CheckerBoard.new
game.set_board
# game.display

game[[2,0]].perform_slide([2,0], [3,1])
puts
game.display

game[[5,3]].perform_slide([5,3], [4,2])
puts
game.display

game[[5,5]].perform_slide([5,5], [4,4])
puts
game.display

game[[6,6]].perform_slide([6,6], [5,5])
puts
game.display

game[[7,5]].perform_slide([7,5], [6,6])
puts
game.display


game[[3,1]].perform_moves([[3,1], [5,3], [7,5]])
puts
game.display
