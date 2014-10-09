require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'AssociationTest' do
    it 'should create an Association object' do
      association = SimpleJsonApi::Association.new(
        'project', :has_one, ProjectSerializer
      )
      association.name.must_equal 'project'
      association.type.must_equal :has_one
      association.serializer.must_equal ProjectSerializer
      association.key.must_equal :project
      refute association.polymorphic
    end

    it 'should create an Association for a polymorphic object' do
      association = SimpleJsonApi::Association.new(
        'project', :has_many, ProjectSerializer, true
      )
      association.name.must_equal 'project'
      association.type.must_equal :has_many
      association.serializer.must_equal ProjectSerializer
      association.key.must_equal :projects
      assert association.polymorphic
    end
  end
end
