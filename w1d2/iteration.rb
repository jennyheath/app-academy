def factors(num)
  (1..num).select {|factor| num % factor == 0}
end

def bubble_sort(num_arr)

  sorted = false

  until sorted
    sorted = true
    num_arr.each_with_index do |num, i|
      if i + 1 < num_arr.length && num > num_arr[i + 1]
        num_arr[i], num_arr[i + 1] = num_arr[i + 1], num_arr[i]
        sorted = false
      end
    end
  end

  num_arr

end

def substrings(str)   #cat
  chars = str.chars
  subs = []

  chars.each_index do |i|
    i.upto(chars.length - 1) do |j|
      subs << chars[i..j].join
    end
  end
  subs
end

def subwords(str)
  nonsense_words = substrings(str)
  dictionary = File.readlines("dictionary.txt").map(&:chomp)
  real_words = nonsense_words.select{|word| dictionary.include?(word)}
end
