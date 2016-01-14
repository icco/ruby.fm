source 'https://rubygems.org'

ruby '2.2.3'

gem 'carrierwave',    '~> 0.10.0'
gem 'coffee-rails',   '~> 4.1.0'
gem 'dalli',          '~> 2.7.4'
gem 'devise',         '~> 3.5.2'
gem 'fog',            '~> 1.27',  require: 'fog/aws/storage'
gem 'imgix',          '~> 0.3.4'
gem 'jbuilder',       '~> 2.0'
gem 'jquery-rails',   '~> 4.0.3'
gem 'metamagic',      '~> 3.1.7'
gem 'rails_admin'
gem 'nokogiri',       '~> 1.5'
gem 'obscenity',      '~> 1.0.2'
gem 'oj',             '~> 2.12.4'
gem 'pg',             '~> 0.18.1'
gem 'puma',           '~> 2.11.1'
gem 'pundit',         '~> 1.0.0'
gem 'rails',          '~> 4.2.0'
gem 'redcarpet',      '~> 3.2.3'
gem 'sass-rails',     '~> 5.0'
gem 'taglib-ruby',    '~> 0.7.0'
gem 'turbolinks',     '~> 2.5.3'
gem 'uglifier',       '>= 1.3.0'
gem 'friendly_id',    '~> 5.1.0'
gem 'virtus',         '~> 1.0.0'
gem 'mini_magick',    '~> 4.2.4'
gem 'validate_url',   '~> 1.0.0'
gem 'timeliness',     '~> 0.3.7'

# Try to put very little in here, we don't want production to be different than
# dev in general.
group :production do
  # Quiets logs down and adds other various heroku goodness
  gem 'rails_12factor', '~> 0.0.3'
  gem 'lograge'
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
