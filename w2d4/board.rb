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

  def each_tile_with_index(&prc)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        prc.call(row, row_idx, tile, col_idx)
      end
    end
  end

  def set_board
    each_tile_with_index do |row, row_idx, tile, col_idx|
      pos = [row_idx, col_idx]
      if row_idx <= 2
        self[pos] = Piece.new(self, :black, pos) if (row_idx - col_idx).even?
      elsif row_idx >= 5
        self[pos] = Piece.new(self, :red, pos) if (row_idx - col_idx).even?
      end
    end
  end

  def set_test_board
    # self[[4,4]] = Piece.new(self, :red, [4,4])
    # self[[3,3]] = Piece.new(self, :black, [3,3])
    # self[[1,1]] = Piece.new(self, :balck, [1,1])
    # self[[1,1]] = Piece.new(self, :red, [1,1])
    # self[[6,0]] = Piece.new(self, :black, [6,0])
  end

  def display
    puts "   1  2  3  4  5  6  7  8 "
    @grid.each_with_index do |row, row_idx|
      print "#{row_idx + 1} "
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
    each_tile_with_index do |row, row_idx, tile, col_idx|
      if !tile.nil?
        pos = [row_idx, col_idx]
        test_board[pos] = Piece.new(test_board, tile.color, tile.pos.dup, tile.king)
      end
    end
    test_board
  end

  def available_jump_moves(color)
    pieces = []
    each_tile_with_index do |row, row_idx, tile, col_idx|
      if tile
        pieces << tile if tile && tile.color == color
      end
    end

    potential_jump_moves = {}
    pieces.each do |piece|
      # debugger
      potential_jump_moves[piece] = piece.jump_moves(piece.pos).select do |jump_move|
        piece.valid_jump?(piece.pos, jump_move)
      end
    end

    potential_jump_moves
  end

  def available_jump_move?(color)
    !available_jump_moves(color).empty?
  end
end
