source 'https://rubygems.org'

gem 'rails', '5.2.3'
gem 'pg'
gem 'jbuilder', '~> 2.0'
gem 'rack-cors', :require => 'rack/cors'
gem 'kaminari'
gem 'dotenv-rails'
gem 'composite_primary_keys', '11.2.0'
gem 'bulk_insert'
gem 'sucker_punch'
gem 'bootsnap'

gem 'log_file', github: 'prodigasistemas/log_file'
gem 'exception_notification'
gem 'slack-notifier'

gem 'spreadsheet'
gem 'prawn'
gem 'prawn-table'

gem 'sass-rails'

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'barby'
gem 'chunky_png'

group :production do
  gem 'unicorn'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'byebug'
  gem 'thin'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'rb-readline'
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
