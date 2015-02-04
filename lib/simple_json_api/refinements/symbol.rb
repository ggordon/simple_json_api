# SimpleJsonApi
module SimpleJsonApi
  module Refinements
    # Refinements on Hash
    module Symbol
      refine ::Symbol do
        def pluralize
          to_s.pluralize.to_sym
        end

        def singularize
          to_s.singularize.to_sym
        end
      end
    end
  end
end
