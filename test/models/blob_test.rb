require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Blob Model" do
  it 'can construct a new instance' do
    @blob = Blob.new
    refute_nil @blob
  end
end
