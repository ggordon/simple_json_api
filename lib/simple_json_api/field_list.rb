# SimpleJsonApi
module SimpleJsonApi
  # List of Fields for a resource
  class FieldList
    def initialize(fields, root_serializer)
      @fields = fields
      @root_serializer = root_serializer
    end

    def field_list
      @field_list ||= parse
    end

    def parse
      result = {}
      if @fields.is_a? Hash
        @fields.each do |resource, fields|
          result[resource.to_sym] = fields.split(',').map(&:to_s)
        end
      end
      result
    end

    def fields_for(resource)
      field_list.fetch(resource, nil)
    end
  end
end
