class IntCode
  attr_reader :memory, :pointer, :current_instruction

  def initialize(memory)
    @memory = memory.dup
    @current_instruction = nil
    @pointer = 0
  end

  def run!
    loop do
      @current_instruction = memory[pointer]
      op_code = current_instruction % 100
      case op_code
      when 1 then add
      when 2 then multiply
      when 3 then input
      when 4 then output
      when 99
        break
      else
        raise "Invalid OpCode #{op_code} from instruction #{current_instruction} at position #{pointer}"
      end
    end
    return memory
  end

  private

  def add
    a = parameter(1)
    b = parameter(2)
    result = a + b
    @memory[memory[pointer + 3]] = result
    @pointer += 4
  end

  def multiply
    a = parameter(1)
    b = parameter(2)
    result = a * b
    @memory[memory[pointer + 3]] = result
    @pointer += 4
  end

  def input
    value = gets.chomp.to_i
    @memory[memory[pointer + 1]] = value
    @pointer += 2
  end

  def output
    puts parameter(1)
    @pointer += 2
  end

  def parameter(parameter_num)
    if current_instruction.digits[parameter_num + 1] == 1
      memory[pointer + parameter_num]
    else
      memory[memory[pointer + parameter_num]]
    end
  end

end