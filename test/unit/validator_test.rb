require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'ValidatorTest' do
    describe 'valid data should pass' do
      it "has valid 'data' resource" do
        json = {
          'data' => { 'id' => '1', 'type' => 'User' }
        }.to_json
        assert SimpleJsonApi::Validator.new.validate(json)
        assert SimpleJsonApi.validate(json)
      end

      it "has valid 'data' array" do
        json = {
          'data' => [
            { 'id' => '1', 'type' => 'User' },
            { 'id' => '2', 'type' => 'User' }
          ]
        }.to_json
        assert SimpleJsonApi::Validator.new.validate(json)
      end
    end

    describe 'Invalid data should have errors' do
      it "is missing 'data' resource" do
        json = { 'id' => '1', 'type' => 'User' }.to_json
        error = lambda do
          SimpleJsonApi::Validator.new.validate(json)
        end.must_raise SimpleJsonApi::ValidationError
        error.message.must_equal "The property '#/' did not contain a required property of 'data'"
      end

      # it "'data' resource doesn't have a 'type'" do
      #   json = {
      #     'data' => { 'id' => '1', 'klass' => 'User' }
      #   }.to_json
      #   error = lambda do
      #     SimpleJsonApi::Validator.new.validate(json)
      #   end.must_raise SimpleJsonApi::ValidationError
      #   error.message.must_equal "The property '#/data' of type Hash did not match one or more of the required schemas"
      # end

      # it "'data' resource doesn't have an 'id'" do
      #   json = {
      #     'data' => [
      #       { 'guid' => '1', 'type' => 'User' },
      #       { 'guid' => '2', 'type' => 'User' }
      #     ]
      #   }.to_json
      #   error = lambda do
      #     SimpleJsonApi::Validator.new.validate(json)
      #   end.must_raise SimpleJsonApi::ValidationError
      #   error.message.must_equal "The property '#/data' of type Array did not match one or more of the required schemas"
      # end
    end
  end
end
