require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderBasicTest' do
    it 'should match json hash for a project with no options' do
      # compare_json(actual_project, expected_project.to_json)
      JSON.parse(actual_project).must_equal expected_project
    end

    it 'should match json hash for a project array with no options' do
      compare_json(actual_projects, expected_projects.to_json)
      JSON.parse(actual_projects).must_equal expected_projects
    end

    let(:actual_project) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer
      )
    end
    let(:expected_project) do
      {
        'projects' => {
          'id' => '100',
          'name' => 'First Project',
          'description' => 'The first project',
          'position' => '',
          'href' => 'http://example.com/projects/100',
          'links' => {
            'todolist' => '200',
            'tags' => %w(10)
          }
        }
      }
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.all.to_a,
        serializer: ProjectSerializer
      )
    end
    let(:expected_projects) do
      {
        'projects' => [
          {
            'id' => '100',
            'name' => 'First Project',
            'description' => 'The first project',
            'position' => '',
            'href' => 'http://example.com/projects/100',
            'links' => {
              'todolist' => '200',
              'tags' => %w(10)
            }
          },
          {
            'id' => '110',
            'name' => 'Second Project',
            'description' => 'The second project',
            'position' => '',
            'href' => 'http://example.com/projects/110',
            'links' => {
              'todolist' => '210',
              'tags' => %w(20)
            }
          }
        ]
      }
    end
  end
end
