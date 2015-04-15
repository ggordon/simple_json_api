require 'simple_json_api/version'

require 'simple_json_api/json_api_wrapper'
require 'simple_json_api/builder'
require 'simple_json_api/resource'
require 'simple_json_api/helper'
require 'simple_json_api/validator'

# require 'simple_json_api/helper'

# SimpleJsonApi
module SimpleJsonApi
  # Main hook to generate json
  def self.render(model:, serializer:, fields: nil, include: nil, page: {}, context: nil, wrapper: JsonApiWrapper)
    Builder.new(model, wrapper, serializer, fields, include, context, page).to_json
  end

  # Validate jsonapi
  def self.validate(json)
    Validator.new.validate(json)
  end
end
