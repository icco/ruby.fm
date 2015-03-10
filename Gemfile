source 'https://rubygems.org'
ruby '2.2.0'

gem 'carrierwave',    '~> 0.10.0'
gem 'coffee-rails',   '~> 4.1.0'
gem 'devise',         '~> 3.4.1'
gem 'fog',            '~> 1.27',  require: 'fog/aws/storage'
gem 'jbuilder',       '~> 2.0'
gem 'jquery-rails',   '~> 4.0.3'
gem 'lograge'
gem 'oj'
gem 'pg',             '~> 0.18.1'
gem 'puma',           '~> 2.11.1'
gem 'pundit',         '~> 0.3.0'
gem 'rails',          '~> 4.2.0'
gem 'rails_12factor', '~> 0.0.3'
gem 'rollbar',        '~> 1.4.4'
gem 'sass-rails',     '~> 5.0'
gem 'taglib-ruby',    '~> 0.7.0'
gem 'uglifier',       '>= 1.3.0'

# Try to put very little in here, we don't want production to be different than
# dev in general.
group :production do
end

group :development, :test do
  gem 'spring'
  gem 'dotenv-rails'
end

group :doc do
  gem 'yard', '~> 0.8.7'
end

group :test do
  gem 'fabrication', '~> 2.12.2'
  gem 'minitest-rails', '~> 2.1.1'
  gem 'mocha', '~> 1.1.0'
end
