class PolyTreeNode
    attr_reader :position
    attr_accessor :parent, :children

    def initialize(position)
        @children = []
        @parent = nil
        @position = position
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
        return self if @position == target
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
        return ele if ele.position == target
        ele.children.each do |node|
          queue.push(node)
        end
      end
      # return nil
    end

    def inspect
      @position.inspect
    end
    
end