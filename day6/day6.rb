#!/usr/bin/env ruby

example_orbits = File.open("day6/example.txt").read.split()
real_orbits = File.open("day6/input.txt").read.split()

class Node
  attr_reader :name, :children, :parent

  def initialize(name)
    @name = name
    @children = []
    @parent = nil
  end

  def add_child(node)
    @children << node
  end

  def orbit(node)
    raise "Must be given an object to orbit!" if node.nil?
    @parent = node
    node.add_child(self)
  end

  def parents
    if parent.nil?
      []
    else
      [self] + parent.parents
    end
  end
end

com = Node.new('COM')
objects = {
  'COM' => com
}
real_orbits.each do |line|
  parent_name, child_name = line.split(')')

  if objects[child_name].nil?
    objects[child_name] = Node.new(child_name)
  end

  if objects[parent_name].nil?
    objects[parent_name] = Node.new(parent_name)
  end

  objects[child_name].orbit(objects[parent_name])
end

def print_tree(node, depth=0)
  if node.children.empty?
    puts "#{node.name} #{depth}"
  else
    puts "#{node.name} #{depth}"
    node.children.each do |child|
      print_tree(child, depth + 1)
    end
  end
end

def count_orbits(node, depth=0)
  if node.children.empty?
    depth
  else
    node.children.map do |child|
      count_orbits(child, depth + 1)
    end.inject(&:+) + depth
  end
end

def find_node(node, name)
  if node.name == name
    node
  else
    node.children.map do |child|
      find_node(child, name)
    end.compact.first
  end
end

puts count_orbits(com)
you = find_node(com, 'YOU')
santa = find_node(com, 'SAN')

puts you.parents.map(&:name).index('P2L')
puts santa.parents.map(&:name).index('P2L')

# P2L
