source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# Tools
####################

gem 'devise' # Users
gem 'state_machine' # Event Based stuff

group :development, :test do
  gem 'sqlite3' # Use sqlite3 as the database for Active Record
  gem 'shoulda'
  gem 'debugger' # Use debugger
  gem 'debugger-xml'
  gem 'better_errors' # Better Errors
  gem 'binding_of_caller'

end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Views

  gem 'sass-rails', '~> 4.0.0' # Use SCSS for stylesheets
  gem 'bootstrap-sass' # Pull our selves up by our Bootstraps
  gem 'slim-rails' # Lose some weight

# Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
  gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'jbuilder', '~> 1.2'# JSON APIs with ease

gem 'tzinfo-data', platforms: [:mingw, :mswin] # Rails Core Windows Dependency, Provides Time Zone Info

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end