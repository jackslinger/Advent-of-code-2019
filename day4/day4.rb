range = 172851..675869

def frequency_count(number)
  number.to_s.split('').map(&:to_i).each_with_object(Hash.new(0)){|key,hash| hash[key] += 1}
end

def double_criteria?(number)
  frequency_count(number).values.any? { |count| count == 2 }
end

def digits_dont_decrease?(number)
  highest_digit = 0
  dont_decrease = true
  number.to_s.split('').map(&:to_i).each do |digit|
    if digit >= highest_digit
      highest_digit = digit
    else
      dont_decrease = false
    end
  end
  return dont_decrease
end

puts range.select{ |num| double_criteria?(num) && digits_dont_decrease?(num) }.size