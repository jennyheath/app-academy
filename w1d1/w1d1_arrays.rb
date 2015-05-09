class Array

  def my_uniq
    new_arr = []
    self.each do |i|
      if !new_arr.include?(i)
        new_arr << i
      end
    end
    return new_arr
  end

  def two_sum
    pairs = []
    i = 0
    while i < self.length - 1
      j = i + 1
      while j < self.length
        if self[i] + self[j] == 0
          pairs << [i, j]
        end
        j += 1
      end
      i += 1
    end
    return pairs
  end

end

#p [1, 2, 1, 3, 3].my_uniq # => [1, 2, 3]
#p [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]


cols = [
    [0, 3, 6, 1],
    [1, 4, 7, 1],
    [2, 5, 8, 1]
  ]

rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]

def my_transpose(arr)
  transposed = Array.new(arr[0].length) { Array.new(arr.length) }

  arr.each_with_index do | inner_arr, index_arr |
    inner_arr.each_with_index do | num, index |
      transposed[index][index_arr] = num
    end
  end
  return transposed

end

# def my_transpose(rows)
#   dimension = rows.first.count
#   cols = Array.new(dimension) { Array.new(rows.count) }

#   dimension.times do |i|
#     dimension.times do |j|
#       cols[j][i] = rows[i][j]
#     end
#   end

#   cols
# end

#p my_transpose(rows)

def picker(arr)
  biggest = 0
  days = Array.new(2)
  arr.each_with_index do |x, day1|
    day2 = day1 + 1
    #arr[day1..-1].each_with_index
    while day2 < arr.length
      diff = arr[day2] - arr[day1]
      if diff > biggest
        biggest = diff
        days = [day1, day2]
      end
      day2 += 1
    end
  end
  return days
end

#p picker([1, 5, 3, 7, 3])

def hanoi
  towers = [[4, 3, 2, 1], Array.new, Array.new]
  solved = [4, 3, 2, 1]
  move_from = 0
  move_to = 0
  disc = 0
  until towers[1] == solved || towers[2] == solved
    puts "select a start"
    move_from = gets.chomp.to_i - 1
    puts "select an end"
    move_to = gets.chomp.to_i - 1

    if towers[move_to].empty? || towers[move_to].last > towers[move_from].last
      disc = towers[move_from].pop
      towers[move_to].push(disc)
    else
      puts "Try again"
    end

    towers.each do |x|
      p x
    end
  end
  puts "You won!!! :)"
end
