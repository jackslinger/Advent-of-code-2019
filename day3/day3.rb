require_relative './coordinate'
require_relative './wire'

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

def intersections(path_1, path_2)
  coords_1 = wire_path_to_coords(path_1)
  coords_2 = wire_path_to_coords(path_2)
  coords_1 & coords_2
end

# wire_1_path = ['R8','U5','L5','D3']
# wire_2_path = ['U7','R6','D4','L4']

# wire_1_path = ['R75','D30','R83','U83','L12','D49','R71','U7','L72']
# wire_2_path = ['U62','R66','U55','R34','D71','R55','D58','R83']



wire_1_path, wire_2_path = File.open("day3/input.txt").read.split()
wire_1_path = wire_1_path.split(',')
wire_2_path = wire_2_path.split(',')

wire_1 = Wire.new(wire_1_path)
wire_2 = Wire.new(wire_2_path)

# example_wire_1 =  Wire.new(['R75','D30','R83','U83','L12','D49','R71','U7','L72'])
# example_wire_2 = Wire.new(['U62','R66','U55','R34','D71','R55','D58','R83'])

# example_wire_1 = Wire.new(['R98','U47','R26','D63','R33','U87','L62','D20','R33','U53','R51'])
# example_wire_2 = Wire.new(['U98','R91','D20','R16','D67','R40','U7','R15','U6','R7'])

intersections = wire_1.intersectons_with(wire_2)
distances = intersections.map do |intersection|
  wire_1.distance_from_origin_by_wire(intersection) + wire_2.distance_from_origin_by_wire(intersection)
end
puts distances.sort[1]
