module SimpleJsonApi
  module Member
    # JSONAPI Links top-level member
    class Links
      def initialize(page)
        @page = page
      end

      def content
        { page: @page } if @page.present?
      end
    end
  end
end
