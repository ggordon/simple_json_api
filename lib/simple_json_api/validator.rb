require 'json-schema'
# SimpleJsonApi
module SimpleJsonApi
  # JSONAPI schema validator
  class Validator
    JSONAPI_SCHEMA = File.dirname(__FILE__) + '/jsonapi-schema.json'

    def initialize(schema: JSONAPI_SCHEMA)
      # @schema = File.open(schema){|f| JSON.parse(f.read)}
      @schema = schema
    end

    def validate(json)
      JSON::Validator.validate(@schema, json)
    end
  end
end
