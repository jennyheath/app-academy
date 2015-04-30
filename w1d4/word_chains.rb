require 'set'

class WordChainer

  def initialize(dictionary_file_name)
    @words = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = Set.new(@words)
  end

  def adjacent_words(word)
    adjacent = []
    (0...word.length).each do |i|
      ("a".."z").each do |letter|
        one_away = word[0...i] + letter + word[i + 1..-1]
        adjacent << one_away if @dictionary.include?(one_away)
      end
    end
    adjacent.select { |adj_word| adj_word != word }
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = Hash.new
    @all_seen_words[source] = nil
    while !@current_words.empty?

      new_current_words = explore_current_words(@current_words, @all_seen_words)
      @current_words = new_current_words
    end

    return build_path(target)
  end

  def explore_current_words(current_words, all_seen_words)
    new_current_words = []

    current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if all_seen_words.include?(adjacent_word)

        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
      end
    end

    new_current_words
  end

  def build_path(target)
    path = []
    previous_word = @all_seen_words[target]

    until previous_word.nil?
      path << previous_word
      previous_word = @all_seen_words[previous_word]
    end

    path
  end

end

c = WordChainer.new("dictionary.txt")
p c.run("duck", "ruby")
p c.run("market", "silver")
# builds path backwards?

# doesn't work for "market" to "target" ??
