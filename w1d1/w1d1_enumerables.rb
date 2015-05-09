class Array

  def double
    self.map do |x|
      2 * x
    end
  end

  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end
end

#p [1,2].double

arr = [1,2]
#arr.my_each do |x|
#  puts x * 2
#end

def median(arr)
  arr = arr.sort
  middle = arr.length / 2
  if arr.length % 2 == 0
    return (arr[middle - 1] + arr[middle])/2.0
  else
    return arr[middle]
  end
end

#p median([2, 5, 1, 3, 4])
#p median([2, 4, 3, 1])

def concatenate(arr)
  return arr.inject("") { |accum, elem| accum + elem }
end

#p concatenate(["this ", "is ", "sentence."])
