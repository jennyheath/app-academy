class David
  def initialize
    @name = 'DAVID'
  end

  def tester
    puts 'it works'
  end
end

d = David.new

class << d
  def an_instance_method_only_for_d
    puts @name
  end
end

d.an_instance_method_only_for_d
