# SimpleJsonApi
module SimpleJsonApi
  # Attribute
  Attribute = Struct.new(:name, :key) do
    def key
      self[:key] || self[:name]
    end
  end
end
