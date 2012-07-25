source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'less-rails-bootstrap'
gem 'debugger'
gem 'thin'
gem 'jquery-rails'
gem 'shopify_app', :git => 'git://github.com/gauravmc/shopify_app.git'

group :development, :test do
  gem 'mysql2'
end

group :test do
  gem 'mocha'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :production, :staging do
  gem "pg"
end
