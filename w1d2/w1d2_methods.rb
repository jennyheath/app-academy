#methods:

class RPS
  attr_reader :computer_tool

  def initialize
    @computer_tool = ["Rock", "Paper", "Scissors"].sample
  end

  def rps(tool)
      user_tool = tool
      if computer_tool == "Rock"
        rock(user_tool)
      elsif computer_tool == "Paper"
        paper(user_tool)
      else
        scissors(user_tool)
      end
  end

  def rock(tool)
    if tool == "Scissors"
      "Rock, Lose"
    elsif tool == "Paper"
      "Rock, Win"
    elsif tool == "Rock"
      "Rock, Draw"
    else
      "invalid tool"
    end
  end

  def paper(tool)
    if tool == "Scissors"
      "Paper, Win"
    elsif tool == "Rock"
      "Paper, Lose"
    elsif tool == "Paper"
      "Paper, Draw"
    else
      "invalid tool"
    end
  end

  def scissors(tool)
    if tool == "Rock"
      "Scissors, Win"
    elsif tool == "Paper"
      "Scissors, Lose"
    elsif tool == "Scissors"
      "Scissors, Draw"
    else
      "invalid tool"
    end
  end

end

# Rock > Scissors > Paper >
# weights = { rock: 3, scissors: 2, paper: 1 }
# u_tool, c_tool = tool.downcase.to_sym, computer_tool.downcase.to_sym
# if weights[u_tool] > weights[c_tool]
# "#{c_tool.to_s.upcase}, "


# Mixology game

def remix(ingredients)
  alcohol, mixer = [], []
  ingredients.each do |combo|
      alcohol << combo.first
      mixer << combo.last
  end

  alcohol.shuffle!
  mixer.shuffle!

  result = []

  alcohol.each {|alc| result << [alc]}
  mixer.each_with_index {|mix, i| result[i] << mix}

  result
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])
