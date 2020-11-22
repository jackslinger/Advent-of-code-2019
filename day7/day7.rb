#!/usr/bin/env ruby

require_relative '../int_code'
require_relative '../simple_pipe'

# Run manually
# IntCode.new(program).run!
# IntCode.new(program).run!
# IntCode.new(program).run!
# IntCode.new(program).run!
# IntCode.new(program).run!

# All zeros
# 60853

program = File.open("day7/input.txt").read.split(',').map(&:to_i)

def test_settings(program, phase_settings)
  pipe = SimplePipe.new([phase_settings.shift, 0])

  amp_a = IntCode.new(program, input: pipe, output: pipe)
  amp_b = IntCode.new(program, input: pipe, output: pipe)
  amp_c = IntCode.new(program, input: pipe, output: pipe)
  amp_d = IntCode.new(program, input: pipe, output: pipe)
  amp_e = IntCode.new(program, input: pipe, output: pipe)

  pipe.puts phase_settings.shift
  amp_a.run!
  pipe.puts phase_settings.shift
  amp_b.run!
  pipe.puts phase_settings.shift
  amp_c.run!
  pipe.puts phase_settings.shift
  amp_d.run!
  amp_e.run!
  
  pipe.values.first
end

combinations = [0,1,2,3,4].permutation(5).to_a
max_thrust = combinations.map{ |phase_settings| test_settings(program, phase_settings) }.max
puts "Part one: #{max_thrust}"




# def test_feedback_settings(program, phase_settings)
#   pipe_a = SimplePipe.new([phase_settings[0], 0])
#   pipe_b = SimplePipe.new([phase_settings[1]])
#   pipe_c = SimplePipe.new([phase_settings[2]])
#   pipe_d = SimplePipe.new([phase_settings[3]])
#   pipe_e = SimplePipe.new([phase_settings[4]])

#   amp_a = IntCode.new(program, input: pipe_a, output: pipe_b)
#   amp_b = IntCode.new(program, input: pipe_b, output: pipe_c)
#   amp_c = IntCode.new(program, input: pipe_c, output: pipe_d)
#   amp_d = IntCode.new(program, input: pipe_d, output: pipe_e)
#   amp_e = IntCode.new(program, input: pipe_e, output: pipe_a)

#   amp_a.run!
#   amp_b.run!
#   amp_c.run!
#   amp_d.run!
#   amp_e.run!

#   puts pipe_a.values
# end

# example_prog = [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]
# test_feedback_settings(example_prog, [9,8,7,6,5])
