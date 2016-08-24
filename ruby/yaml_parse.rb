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

class Node
  def initialize(p)
    @parent = p
    @childs = []
  end

  def add_child(n)
    @childs << n
  end
  def parent
    @parent
  end
  def childs
    @childs
  end
end
class Tree
  def initialize
    @nodes = []
    @root = Node.new nil
  end

  def add_node(node)
    @nodes<< 

  end
end

def parse(path)
  stack = Stack.new
  io = File.read(path)
  io.each_line do |line|
    #puts line
    stack.push line
  end
  ap stack

end

end

