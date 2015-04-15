module SimpleJsonApi
  module Member
    # JSONAPI Links top-level member
    class Links
      def initialize(root_node, page)
        @root_node = root_node
        @page = page
      end

      def content
        links = {}
        links[:self] = @root_node.serializer.href if @root_node.serializer._context.present?
        links[:page] = @page if @page.present?
        links
      end
    end
  end
end
