require "byebug"

class PolyTreeNode
    attr_reader :value
    attr_accessor :parent, :children

    def initialize(value)
        @children = []
        @parent = nil
        @value = value
    end

    def parent=(node)
        if node.nil?
          @parent = nil 
        else
          if !@parent.nil?
            @parent.children.each_with_index do |search_node, i|
            @parent.children.delete_at(i) if search_node == self
            end
            @parent = node
            node.children << self
          else
            @parent = node
            node.children << self
          end
        end
    end

    def add_child(child)
      child.parent=(self)
    end

    def remove_child(child)
      if !self.children.include?(child)
        raise "argument is not a child of this node"
      end
      child.parent=(nil)
    end

    def dfs(target)
        return self if @value == target
        self.children.each do |child|
          tmp = child.dfs(target)
          return tmp if tmp != nil
        end
        return nil
    end

    def bfs(target)
      queue = [self]
      until queue.empty?
        ele = queue.shift
        return ele if ele.value == target
        ele.children.each do |node|
          queue.push(node)
        end
      end
      # return nil
    end

    def inspect
      @value.inspect
    end
    
end

# root = PolyTreeNode.new('a')
# child1 = PolyTreeNode.new('b')
# child2 = PolyTreeNode.new('c')
# root.children = [child1, child2]
# child1.parent = root
# child2.parent = root

# p root.dfs('c')