def num_to_s(num, base)
  chars = {
            0 => "0",
            1 => "1",
            2 => "2",
            3 => "3",
            4 => "4",
            5 => "5",
            6 => "6",
            7 => "7",
            8 => "8",
            9 => "9",
            10 => "A",
            11 => "B",
            12 => "C",
            13 => "D",
            14 => "E",
            15 => "F"
          }
    num_str = ""
    divisor = 1
    while divisor <= num
      digit = chars[( num / divisor ) % base]
      num_str += digit
      divisor *= base
    end
    return num_str.reverse
end

#p num_to_s(234, 10)
#p num_to_s(234, 2)
#p num_to_s(234, 16)

def caesar_cipher(str, shift)
  shifted = []
  until shift < 26
    shift = shift % 26
  end
  str.chars.each do |char|
    ascii_code = char.ord + shift
    if ascii_code > 122
      ascii_code = (ascii_code % 122) + 96
    end
    shifted << ascii_code.chr
  end
  return shifted.join
end

p caesar_cipher("zany",28)
