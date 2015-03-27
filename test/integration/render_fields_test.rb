require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderFieldsTest' do
    it 'should match json hash for a project with fields specified as hash' do
      actual_project_field_hash.must_match_json expected_project
    end

    it 'should match json hash for a project array with fields specified' do
      actual_projects.must_match_json expected_projects
    end

    it 'should match hash for todo with default_fields specified' do
      actual_todo.must_match_json expected_todo
    end

    let(:actual_project_field_hash) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        fields: { projects: 'name,description' }
      )
    end
    let(:expected_project) do
      {
        'data' => {
          'type' => 'projects',
          'id' => '100',
          'name' => 'First Project',
          'description' => 'The first project',
          'links' => {
            'self' => 'http://example.com/projects/100',
            'todolist' => {
              'linkage' => { 'type' => 'todolists', 'id' => '200' }
            },
            'tags' => {
              'linkage' => [
                { 'type' => 'tags', 'id' => '10' }
              ]
            }
          }
        }
      }
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.all.to_a,
        serializer: ProjectSerializer,
        fields: { 'projects' => 'name,description' }
      )
    end
    let(:expected_projects) do
      {
        'data' => [
          {
            'type' => 'projects',
            'id' => '100',
            'name' => 'First Project',
            'description' => 'The first project',
            'links' => {
              'self' => 'http://example.com/projects/100',
              'todolist' => {
                'linkage' => { 'type' => 'todolists', 'id' => '200' }
              },
              'tags' => {
                'linkage' => [
                  { 'type' => 'tags', 'id' => '10' }
                ]
              }
            }
          },
          {
            'type' => 'projects',
            'id' => '110',
            'name' => 'Second Project',
            'description' => 'The second project',
            'links' => {
              'self' => 'http://example.com/projects/110',
              'todolist' => {
                'linkage' => { 'type' => 'todolists', 'id' => '210' }
              },
              'tags' => {
                'linkage' => [
                  { 'type' => 'tags', 'id' => '20' }
                ]
              }
            }
          }
        ]
      }
    end

    let(:actual_todo) do
      SimpleJsonApi.render(
        model: Todo.first,
        serializer: TodoSerializer
      )
    end
    let(:expected_todo) do
      {
        'data' => {
          'type' => 'todos',
          'id' => '300',
          'action' => 'Milk',
          'links' => {
            'self' => 'http://example.com/todos/300',
            'tags' => {
              'linkage' => [
                { 'type' => 'tags', 'id' => '10' },
                { 'type' => 'tags', 'id' => '30' }
              ]
            }
          }
        }
      }
    end
  end
end
