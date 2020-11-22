#!/usr/bin/env ruby

example = 123456789012
input_image = File.open("day8/input.txt").read.to_i

def split_into_layers(input, width:, height:)
  input = input.to_s.split('').map(&:to_i)
  layers = []

  while input.size > 0
    new_layer = []
    (1..height).each do |i|
      new_layer << input.shift(width)
    end
    layers << new_layer
  end

  return layers
end

def print_layers(layers)
  layers.each_with_index do |layer, i|
    puts "Layer #{i}"
    print_layer(layer)
  end
end

def print_layer(layer)
  layer.each do |row|
    puts row.map{ |digit| digit == 1 ? '.' : ' ' }.join('')
  end
end

def count_num_of_digits(layer, equal_to:)
  layer.flatten.select{ |digit| digit == equal_to }.size
end

# layers = split_into_layers(example, width: 3, height: 2)
layers = split_into_layers(input_image, width: 25, height: 6)

layer_with_fewest_zeros = layers.sort{ |a,b| count_num_of_digits(a, equal_to: 0) <=> count_num_of_digits(b, equal_to: 0) }.first
# print_layer layer_with_fewest_zeros

num_of_ones = count_num_of_digits(layer_with_fewest_zeros, equal_to: 1)
num_of_twos = count_num_of_digits(layer_with_fewest_zeros, equal_to: 2)

# puts num_of_ones
# puts num_of_twos
# puts num_of_ones * num_of_twos


# PART TWO

# example = '0222112222120000'
# layers = split_into_layers(example, width: 2, height: 2)
# print_layers layers

def flatten_layers(layers)
  layers = layers.reverse
  display = layers[0]

  layers.slice(1..-1).each do |layer|
    layer.each_with_index do |row, y|
      row.each_with_index do |digit, x|
        display[y][x] = digit unless digit == 2
      end
    end
  end
  
  return display
end

puts 'Final Image:'
print_layer flatten_layers(layers)