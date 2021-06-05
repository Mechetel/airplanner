source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

gem 'bootstrap-sass', '~> 3.4.1'
gem 'browserify-rails'
gem 'react-rails'
gem 'sassc-rails', '>= 2.1.0'

gem 'aws-sdk-s3', '~> 1.25'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'email_address'
gem 'uglifier', '~> 4.1', '>= 4.1.18'

gem 'active_model_serializers', '~> 0.10.0'
gem 'acts_as_list'
gem 'cancancan'
gem 'devise-bootstrap-views'
gem 'omniauth-facebook'

# File uploader
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'fog-aws'

gem 'listen', '~> 3.0.5'
gem 'rubocop'
gem 'rubocop-rails', require: false

# Backgroud worker
gem 'hiredis', '~> 0.6.1'
gem 'sidekiq', '~> 5.2'

gem 'rexml'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec'
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: '4-0-maintenance'
  #
  # A browser automation framework and ecosystem
  gem 'selenium-webdriver'

  # Keep your Selenium WebDrivers updated automatically
  gem 'capybara-selenium', '~> 0.0.6'
  gem 'dotenv-rails'
  gem 'webdrivers', '~> 3.7', '>= 3.7.2'

  gem 'airborne'
  gem 'database_cleaner-active_record'
  gem 'faker'
  gem 'fuubar', require: false
  gem 'shoulda-matchers'
  gem 'webrick'

  gem 'capybara-screenshot'
  gem 'poltergeist'

  # Js
  gem 'jasmine'
  gem 'jasmine-rails'
end

group :development do
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 4.1.0'

  gem 'annotate'
  gem 'awesome_pry'
  gem 'guard-livereload'
end
