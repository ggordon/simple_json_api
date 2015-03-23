require 'simple_json_api/version'

require 'simple_json_api/json_api_wrapper'
require 'simple_json_api/builder'
require 'simple_json_api/resource'
require 'simple_json_api/helper'

# require 'simple_json_api/helper'

# SimpleJsonApi
module SimpleJsonApi
  # Main hook to generate json
  def self.render(model:, serializer:, fields: nil, include: nil, page: {}, wrapper: JsonApiWrapper)
    Builder.new(model, wrapper, serializer, fields, include, page).to_json
  end
end
