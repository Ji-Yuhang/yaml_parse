require "bundler"
Bundler.require

module Jyaml
#Stack = Array.extract([
  #:push,
  #:pop,
  #:size,
  #:clear,
  #:inspect,
  #:to_s
#])
class Stack
  extend Forwardable
  attr_reader :stack
  def initialize
    @stack = []
  end

  # the "extract" part :)
  def_delegators :stack, :count, :push, :pop
end 
class Helper
  def self.head(line)
    return -2 if line.nil?
    i = 0
    while line[i] == " "
      i += 1
    end
    i
  end
end
class Node
  attr_accessor :data
  def initialize(p, data)
    @parent = p
    @children = []
    @data = data

    @parent.add_child self if @parent
  end

  def add_child(n)
    @children << n
  end
  def parent
    @parent
  end
  def children
    @children
  end

  def head
    Helper.head(@data)
  end

  def to_hash
    h = Hash.new
    h["data"] = data
    h["children"] = []
    @children.each_with_index do |n,i|
      h["children"]<< n.to_hash
    end
    h
  end
end
class Tree
  def initialize
    @nodes = []
    @root = Node.new nil,nil
    @last = @root
  end

  def add_node(node)
    @nodes<< node
    @last = node
  end

  def add_line(line)
    return if line.strip.empty?
    h = Helper.head(line)
    temp = @last
    while h <= temp.head
      temp = temp.parent
    end
    lh = temp.head
    if h > lh 
      n = Node.new temp, line
    else
      n = Node.new temp.parent, line
    end
    add_node n
  end

  def to_json
    p @root.to_hash
    @root.to_hash
    # @root.children
    # @nodes.each do |n|
      # ap n
    # end
  end
end



def parse(path)
  stack = Stack.new
  tree = Tree.new
  io = File.read(path)
  io.each_line do |line|
    #puts line
    stack.push line

    tree.add_line(line)
  end
  tree.to_json
  # ap tree
  # ap stack

end

end

