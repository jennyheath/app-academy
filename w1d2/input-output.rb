class GuessGame
  attr_reader :comp_num, :player_num

  def initialize
    @comp_num = rand(101)
    @player_num = nil
  end

  def prompt
    puts "Guess a number"
  end

  def play
    guesses = 0
    until won?
      prompt
      @player_num = Integer(gets)

      if player_num > comp_num
        puts "too high"
        guesses += 1
      elsif player_num < comp_num
        puts "too low"
        guesses += 1
      end
    end
    puts "You won! It took you #{guesses == 1 ? "#{guesses} guess" : "#{guesses} guesses"}."
  end

  def won?
    @comp_num == @player_num
  end

end

class FileShuffler
  attr_reader :file

  def self.start
    file_shuffle = FileShuffler.new
    file_shuffle.request
  end

  def initialize
    @file = nil
  end

  def request
    puts "Give me a filename"
    file_name = gets.chomp
    @file = File.readlines(file_name)
    shuffle_lines
  end

  def shuffle_lines
    puts @file.shuffle
  end

end

#FileShuffler.start

#!/usr/bin/env

class RPN
  attr_reader :stack

  def initialize(file=nil)
    @stack = []
  end

  def parse
    @stack = gets.chomp.split(" ").reverse
    @stack.map! do |el|
      case el
      when /\d/
        el.to_i
      else
        el.to_sym
      end
    end
    @stack = ["end"].concat(@stack)
  end

  def calculate
    parse
    nums = []                   # 5 1 2 + 4 × + 3 −
    until @stack == ["end"]
      #print "stack "
      #p @stack
      #print "nums "
      #p nums
      token = @stack.pop
      if token.is_a?(Integer)
        nums << token
      elsif token.is_a?(Symbol) && nums.length >= 2
        unbound_method = operator_method(token)
        num1, num2 = nums.pop, nums.pop
        nums << unbound_method.bind(num2).call(num1)
      end
    end
    nums.first
  end

  def operator_method(symbol)
    Fixnum.instance_method(symbol)
  end

end

if __FILE__ == $PROGRAM_NAME
  if ARGV[0]
    contents = File.readlines(ARGV[0])
    problem = RPN.new(contents)
    puts problem.calculate
  else
    problem = RPN.new
    puts problem.calculate
  end
end
