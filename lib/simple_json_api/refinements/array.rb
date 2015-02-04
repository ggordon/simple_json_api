# SimpleJsonApi
module SimpleJsonApi
  module Refinements
    # Refinements on Array
    module Array
      refine ::Array do
        def includes(includes = nil)
          self
        end
      end
    end
  end
end
