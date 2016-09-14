source 'https://rubygems.org'

gem 'rails', '4.2.7'
gem 'pg'
gem 'jbuilder', '~> 2.0'
gem 'rack-cors', :require => 'rack/cors'
gem 'kaminari'
gem 'dotenv-rails'
gem 'bulk_insert'
gem 'sucker_punch'

gem 'log_file', github: 'prodigasistemas/log_file'
gem 'exception_notification'
gem 'slack-notifier'

gem 'composite_primary_keys'

group :production do
  gem 'unicorn'
end

group :development do
  gem 'byebug'
  gem 'spring'
  gem 'thin'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'capistrano', '3.5.0'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'factory_girl'
end

group :test do
  gem 'shoulda-matchers', '~> 2.0'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'database_cleaner'
end
