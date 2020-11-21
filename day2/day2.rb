class IntCode
  def initialize(input)
    @tape = input.dup
    @pointer = 0
  end

  def run!
    loop do
      instruction = @tape[@pointer]
      case instruction
      when 1
        a = @tape[@tape[@pointer + 1]]
        b = @tape[@tape[@pointer + 2]]
        result = a + b
        @tape[@tape[@pointer + 3]] = result
      when 2
        a = @tape[@tape[@pointer + 1]]
        b = @tape[@tape[@pointer + 2]]
        result = a * b
        @tape[@tape[@pointer + 3]] = result
      when 99
        break
      else
        raise "Invalid OpCode '#{instruction}' at position #{@pointer}"
      end
      @pointer += 4
    end
    return @tape
  end
end


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