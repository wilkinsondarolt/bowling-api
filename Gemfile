source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'blueprinter', '~> 0.25.3'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dry-validation', '~> 1.6.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'dotenv-rails', '~> 2.7.6'
  gem 'pry-byebug', '~> 3.9.0'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 5.0.1'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails', '~> 6.2.0'
end
