#!/usr/bin/env ruby

require_relative '../int_code'

program = File.open("day9/input.txt").read.split(',').map(&:to_i)
prog = IntCode.new(program)
prog.run!
prog.thread.join