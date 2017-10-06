require 'byebug'

class PolyTreeNode

  attr_accessor :children, :value
  attr_reader :parent

  def initialize(value = nil)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(node)
    if parent
      parent.children.delete(self)
    end
    @parent = node
    if parent
      node.children << self unless node.children.include?(self)
    end
  end

  def add_child(node)
    children << node
    node.parent = self
  end

  def remove_child(node)
    if children.delete(node)
      node.parent = nil
    else
      raise "Node is not a child of the current node"
    end
  end

  def dfs(target)
    return self if target == self.value

    children.each do |child|
      result = child.dfs(target)
      next unless result
      return result if result.value == target
    end

    nil
  end

  def bfs(target)

    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target
      queue += node.children
    end

    nil
  end

end
