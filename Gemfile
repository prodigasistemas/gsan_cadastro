source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'pg'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rack-cors', :require => 'rack/cors'
gem 'kaminari'
gem 'dotenv-rails'

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

  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.1.1'
  gem 'capistrano-rails', '~> 1.1.1'
end

group :test do
  gem 'shoulda-matchers'
  gem 'factory_girl'
  gem 'simplecov', require: false
  gem 'database_cleaner'
end
