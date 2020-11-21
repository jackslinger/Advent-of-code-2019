#!/usr/bin/env ruby

require_relative '../int_code'

# test1 = [3,9,8,9,10,9,4,9,99,-1,8]
# IntCode.new(test1).run!

program = File.open("day5/input.txt").read.split(',').map(&:to_i)
IntCode.new(program).run!

