require 'active_record'

# SimpleJsonApi
module SimpleJsonApi
  # Refinements on ActiveRecord
  module ActiveRecordRefinements
    refine ActiveRecord::Base do
      def typed_json_id
        [self.class.to_s.downcase.pluralize, json_id]
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
