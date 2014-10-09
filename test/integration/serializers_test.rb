require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'SerializersTest' do
    it 'should have registered serializers' do
      expected = [
        {
          serializer: TagSerializer,
          resource: :tags,
          primary_key: :guid,
          model: Tag
        },
        {
          serializer: TaggingSerializer,
          resource: :taggings,
          primary_key: :id
        },
        {
          serializer: TodoSerializer,
          resource: :todos,
          primary_key: :id,
          model: Todo
        },
        {
          serializer: TodolistSerializer,
          resource: :todolists,
          primary_key: :id,
          model: Todolist
        },
        {
          serializer: ProjectSerializer,
          resource: :projects,
          model: Project,
          primary_key: :id
        }
      ]
      ResourceSerializer.registered_serializers.must_equal expected
    end
  end
end
