require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Show Model" do
  it 'can construct a new instance' do
    @show = Show.new
    refute_nil @show
  end
end
