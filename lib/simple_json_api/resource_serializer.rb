# SimpleJsonApi
module SimpleJsonApi
  # The Serializer will serialize a model
  class ResourceSerializer < Serializer
    using ActiveRecordRefinements

    def _root_name
      self.class._root_name
    end

    def _fields
      @_fields ||= begin
        defaults = self.class.default_fields.split(',')
        builders = _builder.fields_for(_root_name).presence
        (builders || defaults).map(&:to_sym)
      end
    end

    def serialize
      hash = {}
      attribute_values(hash)
      link_values(hash[:links] = {})
      _association_values
      hash
    end

    def attribute_values(hash)
      _fields.each do |attribute, _attr_opts|
        hash[attribute] = send(attribute).to_s
      end
      hash[:href] = href if self.class.method_defined? :href
    end

    def link_values(root)
      self.class._associations.each do |association|
        root[association.key] = link(association)
      end
    end

    def link(association)
      resource = send(association.name)
      if association.type == :has_many
        resource.to_a.map do |obj|
          association[:polymorphic] ? obj.typed_json_id : obj.json_id
        end
      else
        resource.json_id
      end
    end

    def _associations
      self.class._associations
    end

    def _association_values
      _associations.each do |association|
        name = association[:name]
        obj = send(name)
        _builder.add_linked_elem(
          name,
          obj,
          association,
          @_base
        )
      end
    end
  end
end
