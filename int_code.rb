class StdinWrapper
  def self.poll
    gets.chomp.to_i
  end
end

class IntCode
  attr_reader :memory, :pointer, :current_instruction, :thread

  def initialize(memory, input: StdinWrapper, output: $stdout)
    @input = input
    @output = output
    @memory = memory.dup
    @current_instruction = nil
    @pointer = 0
    @relative_base = 0
  end

  def run!
    @thread = Thread.new do
      loop do
        @current_instruction = memory[pointer]
        op_code = current_instruction % 100
        case op_code
        when 1 then add
        when 2 then multiply
        when 3 then input
        when 4 then output
        when 5 then jump_if_true
        when 6 then jump_if_false
        when 7 then less_than
        when 8 then equal
        when 9 then update_relative_base
        when 99
          break
        else
          raise "Invalid OpCode #{op_code} from instruction #{current_instruction} at position #{pointer}"
        end
      end
    end
    return memory
  end

  private

  def add
    a = parameter(1)
    b = parameter(2)
    result = a + b
    @memory[parameter_address(3)] = result
    @pointer += 4
  end

  def multiply
    a = parameter(1)
    b = parameter(2)
    result = a * b
    @memory[parameter_address(3)] = result
    @pointer += 4
  end

  def input
    value = @input.poll
    if value.nil?
      sleep 0.0001
    else
      @memory[parameter_address(1)] = value
      @pointer += 2
    end
  end

  def output
    @output.puts parameter(1)
    @pointer += 2
  end

  def jump_if_true
    if parameter(1) != 0
      @pointer = parameter(2)
    else
      @pointer += 3
    end
  end

  def jump_if_false
    if parameter(1) == 0
      @pointer = parameter(2)
    else
      @pointer += 3
    end
  end

  def less_than
    if parameter(1) < parameter(2)
      @memory[parameter_address(3)] = 1
    else
      @memory[parameter_address(3)] = 0
    end
    @pointer += 4
  end
  
  def equal
    if parameter(1) == parameter(2)
      @memory[parameter_address(3)] = 1
    else
      @memory[parameter_address(3)] = 0
    end
    @pointer += 4
  end

  def update_relative_base
    @relative_base += parameter(1)
    @pointer += 2
  end

  def parameter_address(parameter_num)
    code = current_instruction.digits[parameter_num + 1].to_i
    case code
    when 0
      memory[pointer + parameter_num]
    when 1
      pointer + parameter_num
    when 2
      @relative_base + memory[pointer + parameter_num]
    else
      raise "Unknown parameter code: #{code}"
    end
  end

  def parameter(parameter_num)
    memory[parameter_address(parameter_num)]
  end

end