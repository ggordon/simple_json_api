# SimpleJsonApi
module SimpleJsonApi
  module Refinements
    # Refinements on Array
    module Array
      refine ::Array do
        def includes(_includes = nil)
          self
        end
      end
    end
  end
end
