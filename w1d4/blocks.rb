class Array

  def my_each(&prc)
    i = 0
    until i == self.length
      prc.(self[i])
      i += 1
    end
    self
  end

  def my_map(&prc)
    result = []
    self.my_each { |el| result << prc.(el) }
    result
  end

  def my_select(&prc)
    result = []
    self.my_each { |el| result << el if prc.(el) }
    result
  end

  def my_inject(&prc)
    accumulator = self.first
    (0...self.length).to_a.my_each do |i|
      next if i == 0
      accumulator = prc.(accumulator, self[i])
    end
    accumulator
  end

  def my_sort!(&prc)
    sorted = false
    until sorted
      swaps = 0
      i = 0
      until i == self.length - 1
        if prc.(self[i], self[i+1]) == 1
          self[i], self[i+1] = self[i+1], self[i]
          swaps += 1
        end
        i += 1
      end
      sorted = true if swaps == 0
    end
    self
  end

  def my_sort(&prc)
    self.dup.my_sort! &prc
  end
end

def eval_block(*args, &prc)
  if !block_given?
    puts "NO BLOCK GIVEN!"
  else
    prc.call(*args)
  end
end
