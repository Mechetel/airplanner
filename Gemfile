source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'jquery-rails'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

gem 'bootstrap-sass', '~> 3.4.1'
gem 'sassc-rails', '>= 2.1.0'
gem 'react-rails'
gem 'browserify-rails'

gem 'uglifier', '~> 4.1', '>= 4.1.18'
gem 'coffee-rails', '~> 4.2'
gem 'aws-sdk-s3', '~> 1.25'
gem 'devise'
gem 'email_address'

gem 'omniauth-facebook'
gem 'devise-bootstrap-views'
gem 'active_model_serializers', '~> 0.10.0'
gem 'acts_as_list'
gem 'cancancan'

# File uploader
gem 'carrierwave'
gem 'mini_magick'

gem 'listen', '~> 3.0.5'
gem 'rubocop', '~> 0.52.1'

# Backgroud worker
gem 'hiredis', '~> 0.6.1'
gem 'sidekiq', '~> 5.2'

gem 'rexml'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem "factory_bot_rails"
  gem 'pry-rails'
  gem 'rspec'
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: "4-0-maintenance"
  gem 'selenium-webdriver'

  gem 'webdrivers'
  gem 'dotenv-rails'
  gem 'webrick'
  gem 'airborne'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'database_cleaner-active_record'
  gem 'fuubar', require: false

  gem 'poltergeist'
  gem 'capybara-screenshot'

  # Js
  gem 'jasmine-rails'
  gem 'jasmine-rails-webpacker', github: 'buildgroundwork/jasmine-rails-webpacker'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate'
  gem 'awesome_pry'
  gem 'guard-livereload'
end
