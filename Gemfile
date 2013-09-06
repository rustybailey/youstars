source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'


group :production do
  gem 'unicorn'
  gem 'pg'
  gem 'rails_12factor'
end

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'angularjs-rails'

gem 'httparty'
gem 'redis'

gem "redis"
gem 'redis-store'
gem 'redis-rails'
gem "resque", '~> 1.22.0'
gem "resque-scheduler"
gem "resque-retry"
gem 'resque-heroku'

gem 'sass-rails', '~> 4.0.0'
gem "compass-rails", "~> 2.0.alpha.0"
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'protected_attributes' # for attr_accessible
gem "hirefire-resource"

gem 'devise'
gem 'omniauth', '1.1.0'
gem 'omniauth-youtube'
gem 'omniauth-oauth2'
gem 'omniauth-google-oauth2', '0.1.17'

gem 'youtube_it', '~> 2.3.1'

group :development, :test do
  gem 'sqlite3'
  gem 'pry', require: 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'quiet_assets'
end
