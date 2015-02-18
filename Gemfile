source 'https://rubygems.org'

# Specify your gem's dependencies in simple_json_api.gemspec
gemspec

version = ENV['RAILS_VERSION'] || '4.1'

case version
when 'master'
  gem 'rails', github: 'rails/rails'
  # Learned from AMS
  # ugh https://github.com/rails/rails/issues/16063#issuecomment-48090125
  gem 'arel', github: 'rails/arel'
when '4.0', '4.1', '4.2'
  gem 'rails', "~> #{version}.0"
else
  fail GemfileError, "Unsupported Rails version - #{version}"
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
end

group :development do
  gem 'rdoc'

  gem 'awesome_print'
  gem 'minitest-match_json', path: '~/BTSync/Code/minitest-match_json'
  gem 'diffy'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'sqlite3'
end
