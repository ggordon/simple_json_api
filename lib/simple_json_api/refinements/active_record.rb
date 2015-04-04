require 'active_record'

# SimpleJsonApi
module SimpleJsonApi
  module Refinements
    # Refinements on ActiveRecord
    module ActiveRecord
      refine ::ActiveRecord::Base do
        def typed_json_id
          { type: self.class.to_s.demodulize.underscore.pluralize, id: json_id }
        end

        def json_id
          send(json_pk).to_s
        end

        def json_pk
          self.class.primary_key.to_sym
        end
      end
    end
  end
end
