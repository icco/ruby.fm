require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Track Model" do
  it 'can construct a new instance' do
    @track = Track.new
    refute_nil @track
  end
end
