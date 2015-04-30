source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'pul_metadata_services', github:'pulibrary/pul_metadata_services', :branch => 'rails_4_1_8'

gem 'hydra-head', github:"projecthydra/hydra-head", :tag => 'v9.0.0.rc2'
gem 'active-fedora', github:"projecthydra/active_fedora", :tag => 'v9.0.0.rc2'
gem 'worthwhile', github:'projecthydra-labs/worthwhile', ref:'92221695093474702c05699a36373f576d31f8bb'


# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'hydra-role-management', '0.1.0'

gem "bower-rails", "~> 0.9.2"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


gem "rsolr", "~> 1.0.6"
gem "devise"
gem "devise-guests", "~> 0.3"

# from https://github.com/projecthydra-labs/active_fedora-noid
gem 'active_fedora-noid'

gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'capistrano-passenger'

group :development, :test do
  gem "rspec-rails"
  gem "jettywrapper"
  gem "byebug"
  gem "factory_girl_rails"
end

group :test do
  gem "capybara"
  gem "poltergeist"
  gem 'vcr', '~> 2.9.3'
  gem 'webmock'
end
