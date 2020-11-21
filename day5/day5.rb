#!/usr/bin/env ruby

require_relative '../int_code'

program = File.open("day5/input.txt").read.split(',').map(&:to_i)
IntCode.new(program).run!