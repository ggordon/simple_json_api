require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rdoc/task'

namespace :coverage do
  desc 'Delete previous coverage results'
  task :clean do
    rm_rf 'coverage'
  end
end

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
  t.libs.push 'test'
end
task test: 'coverage:clean'
task default: :test

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.rdoc_files.include('lib/**/*.rb')
end
