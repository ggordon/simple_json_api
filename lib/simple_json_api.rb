require 'simple_json_api/version'

require 'simple_json_api/active_record_refinements'
require 'simple_json_api/array_refinements'
require 'simple_json_api/association'
require 'simple_json_api/attribute'
require 'simple_json_api/dsl'
require 'simple_json_api/field_list'
require 'simple_json_api/include_list'

require 'simple_json_api/serializer'
require 'simple_json_api/array_serializer'
require 'simple_json_api/resource_serializer'

require 'simple_json_api/json_api_builder'

# SimpleJsonApi
module SimpleJsonApi
  # Main hook to generate json
  def self.render(model:, serializer:, options: {})
    JsonApiBuilder.new(
      model: model,
      serializer: serializer,
      options: options
    ).to_json
  end
end
