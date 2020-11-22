#!/usr/bin/env ruby

require_relative '../int_code'
require_relative '../simple_pipe'

program = File.open("day7/input.txt").read.split(',').map(&:to_i)
example_one = [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]
example_two = [3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10]

# PART TWO
# --------

def run_feedback_loop(program:, phase_settings:)
  pipe_a_in = SimplePipe.new([phase_settings[0], 0])
  pipe_b_in = SimplePipe.new([phase_settings[1]])
  pipe_c_in = SimplePipe.new([phase_settings[2]])
  pipe_d_in = SimplePipe.new([phase_settings[3]])
  pipe_e_in = SimplePipe.new([phase_settings[4]])

  amp_a = IntCode.new(program, input: pipe_a_in, output: pipe_b_in)
  amp_b = IntCode.new(program, input: pipe_b_in, output: pipe_c_in)
  amp_c = IntCode.new(program, input: pipe_c_in, output: pipe_d_in)
  amp_d = IntCode.new(program, input: pipe_d_in, output: pipe_e_in)
  amp_e = IntCode.new(program, input: pipe_e_in, output: pipe_a_in)

  amp_a.run!
  amp_b.run!
  amp_c.run!
  amp_d.run!
  amp_e.run!

  amp_a.thread.join
  amp_b.thread.join
  amp_c.thread.join
  amp_d.thread.join
  amp_e.thread.join
  return pipe_a_in.values.first
end

combinations = [5,6,7,8,9].permutation(5).to_a
start = Time.now

max_thrust = combinations.map{ |phase_settings| run_feedback_loop(program: program, phase_settings: phase_settings) }.max
puts "#{max_thrust}"

finish = Time.now

puts finish - start

# puts run_feedback_loop(program: example_one, phase_settings: [9,8,7,6,5])
# puts run_feedback_loop(program: example_two, phase_settings: [9,7,8,5,6])
