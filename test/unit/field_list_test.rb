require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'FieldListTest' do
    it 'should parse string field list' do
      fl = FieldList.new(
        fields: 'id,name',
        root_serializer: ProjectSerializer
      )
      fl.fields_for(:projects).must_equal %w(id name)
      fl.fields_for(:todos).must_equal nil
    end

    it 'should parse hash field list' do
      fl = FieldList.new(
        fields:
          { 'projects' => 'id,name',
            'todos' => 'id,description'
          },
        root_serializer: ProjectSerializer
      )
      fl.fields_for(:projects).must_equal %w(id name)
      fl.fields_for(:todos).must_equal %w(id description)
    end

  end
end
