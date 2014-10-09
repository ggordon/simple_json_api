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
when '4.0', '4.1'
  gem 'rails', "~> #{version}.0"
when '4.2'
  gem 'rails', "~> #{version}.0.rc0"
else
  fail GemfileError, "Unsupported Rails version - #{version}"
end
