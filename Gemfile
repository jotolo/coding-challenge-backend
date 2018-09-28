source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5.2'
# Use Puma as the app server
gem 'puma', '~> 3.7'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a
  # debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Use Rspec as testing tool
  gem 'rspec-rails'
  # Use Faker to create seeds or factories
  gem 'faker', git: 'https://github.com/stympy/faker'

  # Test suite
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'

  # Linters
  gem 'overcommit'
  gem 'rubocop'
end

group :test do
  gem 'simplecov', '0.16.1', require: true
  gem 'simplecov-csv', '0.1.3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # GraphiQL editor
  gem 'graphiql-rails', '1.4.10'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# TODO: Put gem versions

# Pagination
gem 'will_paginate'

# Background Jobs
gem 'sidekiq'
gem 'sidekiq-cron'

# Documentation
gem 'apipie-rails'

# GraphQL
gem 'graphql', '1.7.14'
gem 'graphql-batch', '0.3.9'
gem 'graphql-errors', '0.2.0'
gem 'graphql-preload', '1.0.4'
