require_relative './coordinate'

class Wire
  attr_reader :segments

  def initialize(instructions)
    @segments = wire_path_to_coords(instructions)
  end

  def intersectons_with(other)
    segments & other.segments
  end

  def distance_from_origin_by_wire(coordinate)
    segments.index(coordinate)
  end

  private

  def wire_path_to_coords(path)
    coords = [Coordinate.new(0,0)]

    path.each do |instruction|
      direction = instruction[0]
      distance = instruction[1..-1]
      case direction
      when 'R'
        distance.to_i.times do |i|
          coords << coords.last.right
        end
      when 'L'
        distance.to_i.times do |i|
          coords << coords.last.left
        end
      when 'U'
        distance.to_i.times do |i|
          coords << coords.last.up
        end
      when 'D'
        distance.to_i.times do |i|
          coords << coords.last.down
        end
      else
        raise "Unknown direction #{direction}"
      end
    end

    return coords
  end

end