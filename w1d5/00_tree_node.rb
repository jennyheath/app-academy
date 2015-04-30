class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent)
    @parent.children.delete(self) if @parent
    @parent = parent
    parent.children << self if parent #@parent or parent??
  end

  def add_child(child_node)
    child_node.parent = self unless child_node.nil?
  end

  def remove_child(child_node)
    if child_node.parent == self
      child_node.parent = nil
    else
      raise "node is not a child of parent"
    end
  end

  def dfs(target_value)
    if value == target_value
      return self
    else
      children.each do |child|
        result = child.dfs(target_value)
        return result if result
      end
    end
    nil
  end

  def bfs(target_value)
    queue = []
    queue.push(self)
    until queue.empty?
      node = queue.shift
      if node.value == target_value
        return node
      else
        node.children.each { |child| queue.push(child) }
        #queue.concat(node.children)
      end
    end
  end

  def trace_path_back
    if self.parent.nil?
      [self.value]
    else
      [self.value] + self.parent.trace_path_back
    end
  end
end

# node1 = PolyTreeNode.new('a')
# node2 = PolyTreeNode.new('b')
# node3 = PolyTreeNode.new('c')
#
# node3.parent = node2
# node2.parent = node1
#
# p node3.trace_path_back
