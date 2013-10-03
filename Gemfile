source 'https://rubygems.org'

gem 'rails', '4.0.0'

# Backend
gem 'dalli'
gem 'foreman'
gem 'memcacheable'
gem 'pg'
gem 'pg_search'
gem 'puma'
gem 'rack-no-www'

# Frontend
gem 'sass-rails',   '~> 4.0.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder',     '~> 1.2'

group :production do
  gem 'therubyracer', platforms: :ruby
end

group :development, :test do
  gem 'faker'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :development do
  gem 'annotate'
  gem 'haml-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'guard-spork'
  gem 'libnotify'
  gem 'rb-inotify'
  gem 'database_cleaner', '~> 1.0.0.RC1'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
