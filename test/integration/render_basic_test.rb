require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderBasicTest' do
    it 'should match json hash for a project with no options' do
      actual_project.must_match_json expected_project
    end

    it 'should match json hash for a project array with no options' do
      actual_projects.must_match_json expected_projects
    end

    let(:actual_project) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        context: { base_url: 'http://example.com' }
      )
    end
    let(:expected_project) do
      {
        'links' => {
          'self' => 'http://example.com/projects/100'
        },
        'data' => {
          'type' => 'projects',
          'id' => '100',
          'name' => 'First Project',
          'description' => 'The first project',
          'position' => '',
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
        context: { base_url: 'http://example.com' }
      )
    end
    let(:expected_projects) do
      {
        'links' => {
          'self' => 'http://example.com/projects'
        },
        'data' => [
          {
            'type' => 'projects',
            'id' => '100',
            'name' => 'First Project',
            'description' => 'The first project',
            'position' => '',
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
            'position' => '',
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
  end
end
