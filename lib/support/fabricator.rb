require 'fabrication'

Fabrication.configure do |config|
  config.fabricator_path = 'lib/fabricators'
  config.path_prefix = Rails.root
  config.sequence_start = 1
end
