source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


group :development, :test do
	gem 'sqlite3'
	gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
	gem "rspec",              :git => "git://github.com/rspec/rspec.git"
	gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
	gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
	gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"
	gem 'spork', '0.9.2'

end

group :test do
	gem "factory_girl_rails", ">= 1.6.0"
	gem "cucumber-rails", ">= 1.2.1"
	gem "capybara"
  	gem "database_cleaner"
	gem 'launchy'
	gem 'rb-fchange', '0.0.5'
  	gem 'rb-notifu', '0.0.4'
  	gem 'win32console', '1.3.0'

end



group :production do
	gem 'pg'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass', '~> 2.2.2.0'
  gem 'jquery-ui-bootstrap-rails'
  gem 'coffee-rails', '~> 3.2.1'

  # See github://https.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'


gem "heroku"