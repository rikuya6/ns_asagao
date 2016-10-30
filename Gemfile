source 'https://rubygems.org'

gem 'rails', '4.2.7.1'
gem 'rails-i18n'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bcrypt'
gem 'will_paginate'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # gem 'sqlite3'
  gem 'mysql2'
  gem 'byebug'
  gem 'guard'
  gem 'railroady'
end

group :test do
  gem 'factory_girl_rails'
  gem 'minitest-reporters'
  gem 'mini_backtrace'
  gem 'guard-minitest'
end

group :development do
  gem 'web-console'
  gem 'spring'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'puma'
end
