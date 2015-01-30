source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'pg'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rack-cors', :require => 'rack/cors'
gem 'kaminari'

group :production do
  gem 'unicorn'
end

group :development do
  gem 'byebug'
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'dotenv-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'factory_girl'
  gem 'simplecov', require: false
  gem 'database_cleaner', git: 'git@github.com:DatabaseCleaner/database_cleaner.git'
end

