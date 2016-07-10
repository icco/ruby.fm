source 'https://rubygems.org'

ruby '2.3.1'

gem 'addressable',    '~> 2.3.5'
gem 'bugsnag',        '~> 3.0.0'
gem 'carrierwave-aws', '~> 1.0.0'
gem 'coffee-rails',   '~> 4.1.0'
gem 'dalli',          '~> 2.7.4'
gem 'devise',         '~> 4.1.1'
gem 'fog',            '~> 1.37.0',  require: 'fog/aws/storage'
gem 'friendly_id',    '~> 5.1.0'
gem 'htmlentities'
gem 'imgix',          '~> 1.0.0'
gem 'jbuilder',       '~> 2.4.0'
gem 'jquery-rails',   '~> 4.0.3'
gem 'keen',           '~> 0.9.4'
gem 'metamagic',      '~> 3.1.7'
gem 'mini_magick',    '~> 4.2.4'
gem 'nokogiri',       '~> 1.6.7'
gem 'obscenity',      '~> 1.0.2'
gem 'oj',             '~> 2.12.4'
gem 'pg',             '~> 0.18.1'
gem 'puma',           '~> 2.16.0'
gem 'pundit',         '~> 1.1.0'
gem 'rails',          '~> 4.2.6'
gem 'rails_admin',    '~> 0.8.1'
gem 'redcarpet',      '~> 3.3.4'
gem 'redis-rails',    '~> 4.0.0'
gem 'sass-rails',     '~> 5.0.4'
gem 'sidekiq',        '~> 4.1.0'
gem 'taglib-ruby',    '~> 0.7.0'
gem 'timeliness',     '~> 0.3.7'
gem 'turbolinks',     '~> 2.5.3'
gem 'uglifier',       '>= 1.3.0'
gem 'validate_url',   '~> 1.0.0'
gem 'virtus',         '~> 1.0.0'

# Try to put very little in here, we don't want production to be different than
# dev in general.
group :production do
  # Quiets logs down and adds other various heroku goodness
  gem 'rails_12factor', '~> 0.0.3'
  gem 'lograge', '~> 0.3.5'
end

group :development, :test do
  gem 'spring'
  gem 'dotenv-rails', '2.0.2'
end

group :doc do
  gem 'yard', '~> 0.8.7'
end

group :test do
  gem 'fabrication', '~> 2.12.2'
  gem 'minitest-rails', '~> 2.1.1'
  gem 'mocha', '~> 1.1.0'
end
