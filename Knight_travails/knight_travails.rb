require_relative "Polytreenode"

class KnightPathFinder
    attr_reader :root_node, :position, :considered_positions

    def initialize(position) #initial position of knight
        @root_node = PolyTreeNode.new(position)
        @position = position
        @considered_positions = [position]
    end

    def self.valid_moves(position)
        x, y = position[0], position[1]
        possible_pos = []
        possible_pos << [x+2, y+1]
        possible_pos << [x-2, y+1]
        possible_pos << [x+2, y-1]
        possible_pos << [x-2, y-1]
        possible_pos << [x+1, y+2]
        possible_pos << [x-1, y+2]
        possible_pos << [x+1, y-2]
        possible_pos << [x-1, y-2]
        possible_pos.select {|pos| pos[0].between?(0,7) && pos[1].between?(0,7)}
    end

    def new_move_positions(position)
        pos = KnightPathFinder.valid_moves(position).select {|move| !@considered_positions.include?(move)}
        @considered_positions += pos
        pos
    end

    def build_move_tree #bfs
        queue = [@root_node]
        until queue.empty?
            node = queue.shift
            new_move_positions(node.position).each do |pos|
                child_node = PolyTreeNode.new(pos) #create new node object each new position
                child_node.parent = node #make the parent node the new mode so we can move to next mode to check
                queue << child_node
            end
        end
    end
end

kpf = KnightPathFinder.new([0,0])
# p KnightPathFinder.valid_moves([0,0])
kpf.build_move_tree
p kpf.root_node.children
p kpf.root_node.children[0].children
# p kpf.root_node.children[1].children
p kpf.root_node.children[0].children[0].children
# p kpf.root_node.children[0].children[1].children
# p kpf.root_node.children[0].children[2].children
# p kpf.root_node.children[0].children[3].children
# p kpf.root_node.children[0].children[4].children
p kpf.root_node.children[0].children[0].children[0].children
p kpf.root_node.children[0].children[0].children[0].children[0].children
p kpf.root_node.children[0].children[0].children[0].children[0].children[0].children
p kpf.root_node.children[0].children[0].children[0].children[0].children[0].children[0].children

