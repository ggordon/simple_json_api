require 'active_record'
require 'simple_json_api/refinements/active_record'

# SimpleJsonApi
module SimpleJsonApi
  module Refinements
    # Refinements on Hash
    module Array
      refine ::Array do
        using Refinements::ActiveRecord

        def already_linked?(key, id)
          find { |elem| elem[key] == id }
        end
      end
    end
  end
end
