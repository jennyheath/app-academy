class Array
  def my_uniq
    arr = []
    each do |el|
      arr << el unless arr.include?(el)
    end

    arr
  end

  def two_sum
    pairs = []
    (0...count - 1).each do |i|
      (i + 1...count).each do |j|
        pairs << [i, j] if (self[i] + self[j]).zero?
      end
    end

    pairs
  end

  def my_transpose
    transposed = Array.new(self[0].count) { Array.new(self.length) }

    each_with_index do |row, i|
      row.each_index do |j|
        transposed[j][i] = self[i][j]
      end
    end

    transposed
  end

  def stock_picker
    highest_profit = 0
    highest_profit_days = []

    (0...count - 1).each do |day1|
      (day1 + 1...count).each do |day2|
        profit = self[day2] - self[day1]
        if profit > highest_profit
          highest_profit = profit
          highest_profit_days = [day1, day2]
        end
      end
    end

    highest_profit_days
  end
end
