source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7'

# Postgres database driver
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Haml & Bootstrap
gem 'haml'
gem 'haml-rails'
gem 'bootstrap-sass'   #twitter bootstrap
gem 'bootstrap-generators', '~> 3.3.4'
gem 'font-awesome-rails'

# Pagination with kaminari
gem 'kaminari'          

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Authentication process with devise and omniauth
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
# Fake personal data generator
gem 'faker'


# Image upload library
gem "refile", require: "refile/rails"
gem "refile-mini_magick"

# makes Tree in Models 
gem 'ancestry'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'thin'
  gem 'pry'

  gem 'rspec-rails', require: false
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'capybara-screenshot'
  
  gem 'database_cleaner'

  gem 'guard-rspec', require: false
  gem 'kaminari-rspec'
  gem 'simplecov', :require => false

  #gem 'shoulda'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'ruby-beautify'
  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end