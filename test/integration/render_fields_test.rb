require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderFieldsTest' do
    it 'should match json hash for a project with fields specified' do
      actual_project.must_match_json expected_project
    end

    it 'should match json hash for a project with fields specified as hash' do
      actual_project_field_hash.must_match_json expected_project
    end

    it 'should match json hash for a project array with fields specified' do
      actual_projects.must_match_json expected_projects
    end

    it 'should match hash for todo with default_fields specified' do
      actual_todo.must_match_json expected_todo
    end

    let(:actual_project) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        options: { fields: 'name,description' }
      )
    end
    let(:actual_project_field_hash) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        options: { fields: { projects: 'name,description' } }
      )
    end
    let(:expected_project) do
      {
        'projects' => {
          'name' => 'First Project',
          'description' => 'The first project',
          'href' => 'http://example.com/projects/100',
          'links' => {
            'todolist' => '200',
            'tags' => ['10']
          }
        }
      }
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.all.to_a,
        serializer: ProjectSerializer,
        options: { fields: 'name,description' }
      )
    end
    let(:expected_projects) do
      {
        'projects' => [
          {
            'name' => 'First Project',
            'description' => 'The first project',
            'href' => 'http://example.com/projects/100',
            'links' => {
              'todolist' => '200',
              'tags' => ['10']
            }
          },
          {
            'name' => 'Second Project',
            'description' => 'The second project',
            'href' => 'http://example.com/projects/110',
            'links' => {
              'todolist' => '210',
              'tags' => ['20']
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
        'todos' => {
          'id' => '300',
          'action' => 'Milk',
          'href' => 'http://example.com/todos/300',
          'links' => {
            'tags' => %w(10 30)
          }
        }
      }
    end
  end
end
