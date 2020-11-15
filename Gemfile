source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'
gem 'rails', '6.0.3.4'

# Application server
gem 'puma', '~> 4.1'

# Assets
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'

gem "bootstrap4-datetime-picker-rails"
gem 'momentjs-rails'
gem 'bootstrap-datepicker-rails'

# slim
gem 'slim-rails'
gem 'html2slim'

# UI/UX
gem 'rails-i18n'
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem "simple_calendar", "~> 2.0"

# Database
gem 'mysql2', '>= 0.4.4'
gem 'redis-rails'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'


# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Authentication
gem 'pundit'
# gem 'cancancan'
gem 'sorcery'

# Background Job
gem 'whenever'

# Configuration
gem 'config'
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Form
gem 'cocoon'
gem 'simple_form'

group :development, :test do
  # Test
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false

  # Debugger
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # gem 'webdrivers'
  # gem 'faker'
  # gem 'fuubar'
  # gem 'shoulda-matchers'
  # gem 'timecop'
  # gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
