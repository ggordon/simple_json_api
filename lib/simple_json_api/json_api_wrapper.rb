require 'simple_json_api/member/data'
require 'simple_json_api/member/included'
require 'simple_json_api/member/links'
require 'simple_json_api/member/meta'

module SimpleJsonApi
  # JSONAPI Wrapper
  class JsonApiWrapper
    def initialize(root_node, page)
      @root_node = root_node
      @page = page
      @result = {}
    end

    def as_json(_options = nil)
      add_members
      @result.delete_if { |key, content| content.blank? && key != :data }
      @result
    end

    private

    def add_members
      links
      meta
      data
      included
    end

    def links
      page = @root_node.collection? ? @page : {}
      @result[:links] ||= Member::Links.new(@root_node, page).content
    end

    def meta
      @result[:meta] ||= Member::Meta.new.content
    end

    def data
      @result[:data] ||= Member::Data.new(@root_node).content
    end

    def included
      @result[:included] ||=
        Member::Included.new(@root_node, @result[:data]).content
    end
  end
end
