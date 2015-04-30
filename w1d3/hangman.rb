class Hangman
  attr_reader :board
  def initialize(guesser, checker)
    @guesser = guesser
    @checker = checker
    @wrong_guesses = 0
  end
  
  def play
    if @checker.is_a? HumanPlayer
      puts "How long is your word?"
      @checker.word_length = @guesser.word_length = Integer(gets)
    end
    @guesser.board = @checker.create_board
    until won? || @wrong_guesses >= 100
      display #only for computer checker
      guess = @guesser.take_guess
      if @checker.correct_letter?(guess)
        @checker.fill_in(guess)
      else
        @wrong_guesses += 1
        "Bad Guess, try again"
      end
    end
    puts won? ? "Win!" : "Game Over"
  end

  def display
    @checker.board.each do |char|
      print(char.nil? ? "_ " : char + " ")
    end
    puts
  end

  def won?
    !@checker.board.include?(nil)
  end
end

class HumanPlayer
  attr_accessor :word_length, :board

  def create_board
    @board = Array.new(@word_length)
  end

  def correct_letter?(letter)
    puts letter
    puts "Is this letter in your word? (y or n)"
    answer = gets.chomp
    answer == "y" ? true : false
  end

  def fill_in(letter)
    puts "How many times?"
    frequency = Integer(gets.chomp)
    frequency.times do
      puts "Where?"
      i = Integer(gets.chomp)
      @board[i] = letter
    end
  end

  def take_guess
    print "Pick a letter\t"
    letter = gets.chomp.downcase
    if valid?(letter)
      letter
    else
      puts "Try Again"
      take_guess
    end
  end

  def valid?(letter)
    condition = letter =~ /[a-z]/ ? true : false

    letter.length == 1 && condition
  end
end

class ComputerPlayer
  attr_accessor :board, :word_length

  def initialize
    @secret_word = pick_secret_word
    @missing_letters = @secret_word.clone
    @previous_guesses = []
  end

  def create_board
    @board = Array.new(@secret_word.length)
  end

  def correct_letter?(guess)
    @missing_letters.split("").include?(guess)
  end

  def fill_in(letter)
    @missing_letters = @missing_letters.gsub(letter, "")
    (0...@secret_word.length).each do |i|
      @board[i] = letter if @secret_word[i] == letter
    end
  end

  def pick_secret_word
    contents = File.readlines("dictionary.txt").map(&:chomp)
    contents.select! { |word| word.length.between?(4, 8) }
    contents.sample
  end

  def take_guess
    if @board.all? { |x| x.nil? }
      guess = %w(a e i o u).sample
    else
      guess = smart_guess
    end
    if @previous_guesses.include?(guess)
      take_guess
    else
      @previous_guesses << guess
      guess
    end
  end

  def smart_guess
    words = File.readlines("dictionary.txt").map(&:chomp)
    words = words.select { |word| word.length == @word_length } #whyyyyy
    indices = [*(0...@board.length).select { |i| @board[i] != nil}]
    smart_words = words.select do |word|
      indices.all? { |i| word[i] == @board[i] }
    end
    smart_letters = smart_words.join("")
    @previous_guesses.each do |letter|
      smart_letters = smart_letters.gsub(letter, "")
    end
    max_letter = nil
    max_count = 0
    smart_letters.split("").uniq.each do |letter|
      if smart_letters.count(letter) > max_count
        max_count = smart_letters.count(letter)
        max_letter = letter
      end
    end
    max_letter
  end
end


player_one = ComputerPlayer.new
player_two = HumanPlayer.new
game = Hangman.new(player_one, player_two)
game.play