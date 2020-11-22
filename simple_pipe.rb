class SimplePipe
  attr_reader :values

  def initialize(values)
    @values = values
  end

  def puts(value)
    @values.push(value)
  end

  def poll
    @values.shift
  end
end