#!/usr/bin/env ruby
require_relative '../int_code'

def create_memory(program, noun:, verb:)
  program[1] = noun
  program[2] = verb
  program
end

def find_verb_and_noun
  input = File.open("day2/input.txt").read.split(',').map(&:to_i)
  (0..99).each do |verb|
    (0..99).each do |noun|
      output = IntCode.new(create_memory(input, noun: noun, verb: verb)).run![0]
      return [verb, noun] if output == 19690720
    end
  end
end

verb, noun = find_verb_and_noun
puts verb
puts noun
puts 100 * noun + verb