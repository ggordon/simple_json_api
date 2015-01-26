module SimpleJsonApi
  module Generators
    # Generates the resource template files
    class ResourceGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      argument :name, type: :string, required: true, banner: 'ResourceName'

      class_option :model,
                   desc: 'Model class if different than Resource',
                   type: :string
      class_option :namespace,
                   desc: 'Namespace for the generated files',
                   type: :string

      class_option :skip_serializer,
                   desc: "Don't generate a serializer file.",
                   type: :boolean
      class_option :skip_controller,
                   desc: "Don't generate a controller file.",
                   type: :boolean
      class_option :skip_service,
                   desc: "Don't generate a service file.",
                   type: :boolean

      def create_resource
        @namespace = options[:namespace]
        @model = options[:model] || class_name

        ap @namespace
        ap @model
        ap class_name
        check_model!

        template 'serializer_template.rb.erb',
                 "app/serializers/#{@namespace.underscore}" \
                   "/#{class_name.underscore}_serializer.rb" \
                   unless options[:skip_serializer]

        # TODO: create controller
        # TODO: create service
      end

      private

      def check_model!
        unless @model.constantize.ancestors.include?(ActiveRecord::Base)
          fail NameError
        end
      rescue NameError
        puts "Error: '#{@model}' is not an AR model"
        exit
      end
    end
  end
end
