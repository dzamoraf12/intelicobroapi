source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.1"

# Use sqlite3 as the database for Active Record
gem "mysql2", "~> 0.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

gem 'blueprinter' #serializer "https://github.com/procore/blueprinter"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 6.0.0'
  gem "factory_bot_rails"
  gem 'faker' 
  gem 'shoulda-matchers'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'database_cleaner-active_record'
end

gem "devise", "~> 4.8"
gem "devise-jwt", "~> 0.9.0"
gem "rack-cors", "~> 1.1"

# A Ruby gem to load environment variables from .env
gem "dotenv-rails", groups: [:development, :test, :production]

gem "letter_opener", group: :development
gem "mail_interceptor", group: [:development, :staging]

# Pagination api
gem 'pagy', '~> 6.0'
gem 'api-pagination'

# To enable ActiveRecord enums validation
gem 'enum_attributes_validation'

# To use soft delete
gem 'acts_as_paranoid'

gem 'active_storage_validations'
# Optional, to use :dimension validator or :aspect_ratio validator
gem 'mini_magick', '>= 4.9.5'
# gem 'ruby-vips', '>= 2.1.0'

gem 'aws-sdk-s3'