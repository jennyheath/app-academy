class Code
  attr_reader :sequence

  def initialize(sequence)
    @sequence = sequence
  end

  def self.create_random_sequence
    colors = %w(R G B Y O P)
    our_array = []
    4.times { our_array << colors.sample }
    Code.new(our_array)
  end

  def self.create_sequence(str)
    Code.new(str.split(""))
  end
end

# tldc
class Game
  def initialize
    @turns = 0
    @answer = Code.create_random_sequence
    @guess = nil
    @player = Player.new
    p @answer
  end

  def play
    puts "Options: RGBYOP"
    until @turns >= 30
      puts "Turn #{@turns + 1}"
      @guess = @player.input
      if win?
        puts "You Win!"
        break
      else
        @turns += 1
        matches
      end
    end
  end

  def win?
    @answer.sequence == @guess.sequence
  end

  def matches
    exact = exact_matches
    near = total_matches - exact
    puts "Near matches: #{near}, Exact matches: #{exact}"
  end

  def exact_matches
    match_count = 0
    (0..3).each do |i|
      match_count += 1 if @answer.sequence[i] == @guess.sequence[i]
    end

    match_count
  end

  def total_matches
    total_count = 0
    answer, guess = @answer.sequence, @guess.sequence
    guess.each do |char|
      if answer.include?(char)
        answer = answer.join("").sub(char, "").split("")
        total_count += 1
      end
    end

    total_count
  end
end

class Player
  def input
    puts "What's your guess?"
    guess = gets.chomp.upcase
    if valid?(guess)
      Code.create_sequence(guess)
    else
      puts "Nope. Try again."
      input
    end
  end

  def valid?(seq)
    guess = seq.chars
    condition1 = guess.length == 4
    condition2 = guess.all? { |color| %w(R G B Y O P).include?(color) }

    condition1 && condition2
  end
end

this_game = Game.new
this_game.play