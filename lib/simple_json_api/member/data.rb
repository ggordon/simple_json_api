module SimpleJsonApi
  module Member
    # JSONAPI Data top-level member
    class Data
      def initialize(root_node)
        @root_node = root_node
      end

      def content
        @root_node.serialize
      end
    end
  end
end
