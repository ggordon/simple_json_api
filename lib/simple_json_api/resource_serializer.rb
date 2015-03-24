require 'simple_json_api/refinements/active_record'
require 'simple_json_api/refinements/symbol'

# SimpleJsonApi
module SimpleJsonApi
  # The Serializer will serialize a model
  class ResourceSerializer < Serializer
    using Refinements::ActiveRecord
    using Refinements::Symbol

    def _root_name
      self.class._root_name
    end

    def type
      _root_name
    end

    def id
      _object.try(:id) || _object.try(:guid)
    end

    def _fields
      @_fields ||= _get_fields
    end

    # If default_fields is not specified, use all_fields
    def _get_fields
      builder_fields
    end

    def serialize
      hash = {}
      attribute_values(hash)
      link_values(hash[:links] = {})
      Resource.new(hash)
    end

    def attribute_values(hash)
      _fields.each do |attribute, _attr_opts|
        hash[attribute] = send(attribute).to_s
      end
    end

    def link_values(root)
      root[:self] = href if self.class.method_defined? :href
      self.class._associations.each do |association|
        root[association.key] = link(association)
      end
    end

    def link(association)
      if association.type == :has_many
        link_many(association)
      else
        link_one(association)
      end
    end

    def link_many(association)
      resource = send(association.name, includes(association))
      resource.map do |obj|
        association[:polymorphic] ? obj.typed_json_id : obj.json_id
      end
    end

    def link_one(association)
      resource = send(association.name)
      resource.json_id if resource
    end

    def includes(association)
      if association.polymorphic
        []
      else
        Serializer.includes(association)
      end
    end

    def _associations
      self.class._associations
    end
  end
end
