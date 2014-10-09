require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'AttributeTest' do
    it 'should create an Attribute object' do
      attribute = SimpleJsonApi::Attribute.new(
        'description'
      )
      attribute.name.must_equal 'description'
      attribute.key.must_equal 'description'
    end

    it 'should create an Attribute object and override key' do
      attribute = SimpleJsonApi::Attribute.new(
        'description', 'content'
      )
      attribute.name.must_equal 'description'
      attribute.key.must_equal 'content'
    end
  end
end
