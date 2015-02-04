module SimpleJsonApi
  # The representation of a Resource
  class Resource
    extend Forwardable
    def_delegators :@content, :[], :as_json

    def initialize(content)
      @content = content
    end

    def ==(other)
      (@content[:type] &&
        (@content[:type] == other[:type])) &&
        (@content[:id] &&
          (@content[:id] == other[:id]))
    end
    # alias_method :eql?, :==

    # def hash
    #   [@content[:id], @content[:type], Resource].hash
    # end
  end
end
