require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    board_node = TicTacToeNode.new(game.board, mark)
    if board_node.children.any? { |child| child.winning_node?(mark) }
      board_node.children.each do |child|
        return child.prev_move_pos if child.winning_node?(mark)
      end
    else
      board_node.children.each do |child|
        return child.prev_move_pos if child.losing_node?(mark) == false
      end
    end
      raise "WE MUST WIN"
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
