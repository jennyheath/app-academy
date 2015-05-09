class Array

  def deep_dup
    self.map do |el|
      if el.is_a?(Array)
        el.deep_dup
      else
        [] << el
      end
    end
  end

end

class Queens
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    # @queen_count = 0
    # @board.each { |row| p row }
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @board[row][col]
  end

  def []=(pos, mark)
    row, col = pos[0], pos[1]
    @board[row][col] = mark
  end

  def rows
    @board
  end

  def cols
    columns = Array.new(8) { Array.new(8) }
    columns.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        columns[col_idx][row_idx] = self[[row_idx, col_idx]]
      end
    end
    columns
  end

  def diags(pos)
    diagonals = []

    rows.each_index do |row|
      cols.each_index do |col|
        if (pos[0] - row).abs == (pos[1] - col).abs
          diagonals << [row, col]
        end
      end
    end

    diagonals
  end

  def valid?(pos)
    if rows[pos[0]].include?("q")
      return false
    elsif cols[pos[1]].include?("q")
      return false
    else
      diags(pos).each do |space|
        return false if self[space] == "q"
      end
    end
    true
  end

  def place_queen(pos)
    if valid?(pos)
      self[pos] = "q"
    end
  end

  def test_idx
    queen_count = 1

    until queen_count >= 8

      current_board = self.board.deep_dup

      self.board.each_with_index do |row, row_idx|
        row.each_with_index do |col, col_idx|
          self.place_queen([row_idx, col_idx])
          queen_count += 1
          break
          # puts "queen count: #{queen_count}"
          # self.board.each { |row| p row }
        end
      end

      changed = false
      self.board.each_with_index do |row, row_idx|
        row.each_with_index do |col, col_idx|
          if self.board[row_idx][col_idx] != current_board[row_idx][col_idx][0]
            changed = true
          end
        end
      end

      return false if changed == false

      # print "changed: "
      # p changed
      # puts "self.board: "
      # self.board.each { |row| p row }
      # puts "current_board: "
      # current_board.each { |row| p row }
    end

    # puts "found it!"
    return true
  end

  def run
    @board[0].each_with_index do |place, idx|
      board_dup = Queens.new
      board_dup.place_queen([0, idx])
      # puts "duplicate: "
      # print "works?: "
      # p board_dup.test_idx
      # board_dup.board.each {|row| p row }

      if board_dup.test_idx
        puts "found board!"
        #use this starting position
        place_queen([0, idx])
        # queen_count = 1
        # until queen_count == 8
        #   @board.each_with_index do |row, row_idx|
        #     row.each_with_index do |col, col_idx|
        #       place_queen([row_idx, col_idx])
        #       queen_count += 1
        #       break if queen_count == 8
        #     end
        #   end
        # end
        @board.each { |row| p row }
      end
    end
  end


end

board = Queens.new
# board.run
# board[[0, 1]] = "q"
# board.place_queen([1, 2])
# board.place_queen([0, 3])
# board.place_queen([2, 5])
# board.board.each {|row| p row }
