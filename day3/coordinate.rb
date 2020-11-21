class Coordinate
  include Comparable

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def <=>(other)
    [x, y] <=> [other.x, other.y]
  end

  def eql?(other)
    other.kind_of?(self.class) && [x, y] == [other.x, other.y]
  end

  def hash
    [x, y].hash
  end

  def to_s
    "(#{x}, #{y})"
  end

  def manhattan_distance
    (0 - x).abs + (0 - y).abs
  end

  def right
    Coordinate.new(x + 1, y)
  end

  def left
    Coordinate.new(x - 1, y)
  end

  def up
    Coordinate.new(x, y + 1)
  end
  
  def down
    Coordinate.new(x, y - 1)
  end
end