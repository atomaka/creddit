source 'https://rubygems.org'

def darwin_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /darwin/ && require_as
end

def linux_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /linux/ && require_as
end

gem 'rails', '4.2.3'
gem 'sqlite3'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'slim-rails'
gem 'bootstrap-sass'
gem 'simple_form'

gem 'bcrypt'

gem 'sdoc', '~> 0.4.0', group: :doc

group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'pry'
  gem 'spring'
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner', '~> 1.4.1'
  gem 'launchy'
  gem 'faker'
  gem 'capybara-webkit'
  gem 'shoulda'
end
