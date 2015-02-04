module SimpleJsonApi
  module Member
    # JSONAPI Included top-level member
    class Included
      def initialize(root_node, data)
        @root_node = root_node
        @data = data
        @included = []
      end

      def content
        visit(@root_node)
        @included
      end

      def visit(node)
        node.associations.each do |association|
          process(association) if included?(association)
          visit(association)
        end
      end

      def process(association)
        Array[association.serialize].flatten.each do |hash|
          @included << hash unless already_included? hash
        end
      end

      def included?(association)
        association.assoc_list[:include].present?
      end

      def already_included?(resource)
        @included.include?(resource) || Array(@data).include?(resource)
      end
    end
  end
end
