require 'active_record'

# SimpleJsonApi
module SimpleJsonApi
  # Refinements on Hash
  module ArrayRefinements
    refine Array do
      using ActiveRecordRefinements
      def already_linked?(key, id)
        find { |elem| elem[key] == id }
      end
    end
  end
end
