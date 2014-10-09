require 'test_helper'

module SimpleJsonApi
  describe Serializer do
    it 'should fail' do
      puts Project.first.name
      puts Project.first.tags.first.name
      pass 'failed'
    end
  end
end
