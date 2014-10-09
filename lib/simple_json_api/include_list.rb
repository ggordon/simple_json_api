# SimpleJsonApi
module SimpleJsonApi
  # List of Included associations for a resource
  class IncludeList
    def initialize(include:)
      @include = include
      @include_list = []
    end

    def parse
      @include_list = @include.split(',').map(&:to_s) if @include.is_a? String
      self
    end

    def include?(resource, parent = [])
      path = [parent, resource].flatten.compact.join('.')
      @include_list.include?(path)
    end
  end
end
